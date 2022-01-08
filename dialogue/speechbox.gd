tool
extends Node
class_name SpeechBox
# A node holding a speech box with the text being said and the speaker name

export(NodePath) var speaker_label_path
export(NodePath) var speech_text_label_path

onready var speaker_label: Label = get_node(speaker_label_path)
onready var speech_text_label: RichTextLabel = get_node(speech_text_label_path)

func _ready() -> void:
	# Make speaker name display above speech text box
	VisualServer.canvas_item_set_z_index(speaker_label.get_canvas_item(), 1)

func update_dialogue(text: String, speaker: Character) -> void:
	speaker_label.text = speaker.display_name if speaker else ""
	speech_text_label.bbcode_text = text
