tool
extends Control
class_name Dialogue

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")

export(bool) var use_large_portraits := true
export(bool) var can_advance := false

# The variable name of the current input. If empty, there is no input waiting
# to be entered.
var _input_var_name := ""

onready var story: InkStory = $InkStory
onready var speech_box = $VBoxContainer/MarginContainer/SpeechBox
onready var speaker_label = speech_box.get_node("SpeakerLabel")
onready var speech_text_label = speech_box.get_node("PanelContainer/SpeechTextLabel")
onready var small_portrait = $SmallPortrait
onready var participant_container = $VBoxContainer/Participants
onready var participant_portrait_template = $VBoxContainer/Participants/ParticipantPortraitTemplate.duplicate()


func _ready():
	if not Engine.editor_hint:
		speech_box.connect("gui_input", self, "_on_speechbox_gui_input")

		story.connect("InkContinued", self, "_on_story_continued")
	
		$VBoxContainer/Participants/ParticipantPortraitTemplate.queue_free()

	# Make speaker name display above speech text box
	VisualServer.canvas_item_set_z_index(speaker_label.get_canvas_item(), 1)

func _input(event):
	if (can_advance and not Engine.editor_hint
		and event.is_action_released("ui_accept")):
			story.Continue()

func _on_speechbox_gui_input(event: InputEvent):
	if (can_advance and not Engine.editor_hint
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
		if name == Player.character.ident:  # Don't show the player character ever
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
			var target = speaker.ident if speaker else Player.character.ident
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

	speaker_label.text = speaker.display_name if speaker else ""
	speech_text_label.bbcode_text = text
