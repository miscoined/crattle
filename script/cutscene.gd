extends Control

const TextInputPopup = preload("res://scenes/TextInputPopup.tscn")

onready var background: TextureRect = $Background
onready var location_label: Label = $LocationNameLabel

func _ready():
	var _err = Story.connect("location_changed", self, "update_location")
	_err = Story.connect("story_action_commanded", self, "_on_story_action_commanded")
	Story.bind_external_function("var_from_input", self, "var_from_input")
	Story.advance()

func _on_story_action_commanded(command: String) -> void:
	if command == "force_map":
		get_tree().change_scene("res://scenes/Map.tscn")

func update_location(loc: Location) -> void:
	location_label.text = loc.display_name
	background.texture = loc.background

# Display an input popup to get input from the user and set the result to
# a variable in the ink story
func var_from_input(prompt: String, var_name: String) -> void:
	var popup: TextInputPopup = TextInputPopup.instance().init(var_name, prompt)
	add_child(popup)
	popup.popup_centered()
