tool
extends Control
class_name Dialogue

const Util = preload("res://script/util.gd")
const CharacterPortrait = preload("character/CharacterPortrait.tscn")

export(bool) var can_advance := false
export(NodePath) var speech_box_path
export(NodePath) var participant_container_path
export(NodePath) var small_portrait_path

onready var speech_box = get_node(speech_box_path)
onready var small_portrait = get_node(small_portrait_path)
onready var participant_container = get_node(participant_container_path) if participant_container_path else null
onready var participant_portrait_template = participant_container.get_node("PortraitTemplate").duplicate() if participant_container else null

func _ready():
	if not Engine.editor_hint:
		var _err = speech_box.connect("gui_input", self, "_on_speechbox_gui_input")
		_err = Story.connect("dialogue_advanced", self, "update_dialogue")
		_err = Story.connect("dialogue_participants_changed", self, "update_participants")
	if participant_container:
		Util.hide_or_free(participant_container.get_node("PortraitTemplate"))

func _input(event):
	if (not Engine.editor_hint and can_advance and event.is_action_released("ui_accept")):
			Story.advance()

func _on_speechbox_gui_input(event: InputEvent):
	if (not Engine.editor_hint and can_advance
		and event is InputEventMouseButton
		and event.button_index == BUTTON_LEFT
		and not event.pressed):
			Story.advance()

# Display the portraits of the participants from an array of characters
func update_participants(participants: Array) -> void:
	if not participant_container:
		return
	for child in participant_container.get_children():
		child.queue_free()

	for character in participants:
		var portrait = CharacterPortrait.instance()
		portrait.size_flags_horizontal = 0
		portrait.size_flags_vertical = SIZE_SHRINK_END
		portrait.rect_min_size.x = 450
		portrait.rect_min_size.y = 800
		portrait.character = character
		participant_container.add_child(portrait)
		portrait.show()

func update_dialogue(text: String, speaker: Character) -> void:	
	if not participant_container and speaker:
		small_portrait.character = speaker

	small_portrait.update_portrait()
	if participant_container:
		for portrait in participant_container.get_children():
			portrait.update_portrait()
	speech_box.update_dialogue(text, speaker)
