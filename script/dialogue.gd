tool
extends Control
class_name Dialogue

const Util = preload("res://script/util.gd")

export(bool) var can_advance := false
export(NodePath) var speech_box_path
export(NodePath) var participant_container_path
export(NodePath) var small_portrait_path

# The variable name of the current input. If empty, there is no input waiting
# to be entered.
var _input_var_name := ""

onready var speech_box = get_node(speech_box_path)
onready var small_portrait = get_node(small_portrait_path)
onready var participant_container = get_node(participant_container_path) if participant_container_path else null
onready var participant_portrait_template = participant_container.get_node("PortraitTemplate").duplicate() if participant_container else null

func _ready():
	if not Engine.editor_hint:
		var _err = speech_box.connect("gui_input", self, "_on_speechbox_gui_input")
		_err = Game.story.connect("InkContinued", self, "_on_story_continued")
	if participant_container:
		Util.hide_or_free(participant_container.get_node("PortraitTemplate"))

func _input(event):
	if (not Engine.editor_hint and can_advance and event.is_action_released("ui_accept")):
			Game.story.Continue()

func _on_speechbox_gui_input(event: InputEvent):
	if (not Engine.editor_hint and can_advance
		and event is InputEventMouseButton
		and event.button_index == BUTTON_LEFT
		and not event.pressed):
			Game.story.Continue()

# Display the portraits of the participants from an array of character names
func set_participants(participant_names: Array) -> void:
	if not participant_container:
		return
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
		if tag.begins_with("characters:"):
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
	
	if not participant_container and speaker:
		small_portrait.character = speaker
	small_portrait.update_portrait()
	if participant_container:
		for portrait in participant_container.get_children():
			assert(portrait is CharacterPortrait)
			portrait.update_portrait()

	speech_box.set_dialogue(speaker, text)
