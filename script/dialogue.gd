tool
extends Control
class_name Dialogue

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")
const Util = preload("res://script/util.gd")

export(bool) var use_large_portraits := true
export(bool) var can_advance := false
export(bool) var is_docked := true
export(NodePath) var story_path: NodePath

# The variable name of the current input. If empty, there is no input waiting
# to be entered.
var _input_var_name := ""

onready var story: InkStory = get_node(story_path) if not Engine.editor_hint else null
onready var speech_box = $VBoxContainer/SpeechBoxDocked if is_docked else $VBoxContainer/SpeechBoxFloating
onready var small_portrait = $SmallPortrait
onready var participant_container = $VBoxContainer/Participants
onready var participant_portrait_template = $VBoxContainer/Participants/ParticipantPortraitTemplate.duplicate()


func _ready():
	Util.hide_or_free($VBoxContainer/SpeechBoxFloating if is_docked else $VBoxContainer/SpeechBoxDocked)
	speech_box.show()

	if not Engine.editor_hint:
		var _err = speech_box.connect("gui_input", self, "_on_speechbox_gui_input")
		_err = story.connect("InkContinued", self, "_on_story_continued")

		$VBoxContainer/Participants/ParticipantPortraitTemplate.queue_free()

func _input(event):
	if (not Engine.editor_hint and can_advance and event.is_action_released("ui_accept")):
			story.Continue()

func _on_speechbox_gui_input(event: InputEvent):
	if (not Engine.editor_hint and can_advance
		and event is InputEventMouseButton
		and event.button_index == BUTTON_LEFT
		and not event.pressed):
			story.Continue()

# Display the portraits of the participants from an array of character names
func set_participants(participant_names: Array) -> void:
	for child in participant_container.get_children():
		child.queue_free()

	if participant_names == [""]:
		return
	
	for name in participant_names:
		if name == Game.player.ident:  # Don't show the player character ever
			continue
		var portrait = participant_portrait_template.duplicate()
		portrait.character = Character.load_from_name(name)
		participant_container.add_child(portrait)
		portrait.show()

func _on_story_continued(text: String, tags: PoolStringArray) -> void:
	var speaker = null
	if ":" in text:
		var s = text.split(":", true, 1)
		speaker = Character.load_from_name(s[0])
		text = s[1].strip_edges()
	print("%s %s" % [speaker.name if speaker else "", tags])

	for tag in tags:
		if tag.begins_with("characters:") and use_large_portraits:
			set_participants(tag.trim_prefix("characters:").strip_edges().split(" "))
		if tag.begins_with("face_") or tag.begins_with("pose_"):
			var target = speaker.ident if speaker else Game.player.ident
			if ":" in tag:
				tag = tag.split(":", true, 1)
				target = tag[1]
				tag = tag[0]
				
			var target_char = Character.load_from_name(target)
			if tag.begins_with("face_"):
				target_char.expression_face = tag.trim_prefix("face_")
			elif tag.begins_with("pose_"):
				target_char.expression_pose = tag.trim_prefix("pose_")
	
	if not use_large_portraits and speaker:
		small_portrait.character = speaker
	small_portrait.update_portrait()
	for portrait in participant_container.get_children():
		assert(portrait is CharacterPortrait)
		portrait.update_portrait()

	speech_box.set_dialogue(speaker, text)
