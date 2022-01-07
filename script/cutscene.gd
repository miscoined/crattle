extends Control

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")
const TextInputPopup = preload("res://scenes/TextInputPopup.tscn")

onready var dialogue: Dialogue = $Dialogue
onready var background: TextureRect = $Background
onready var location_label: Label = $LocationNameLabel

func _ready():
	var _err = Game.story.connect("InkContinued", self, "_on_story_continued")
	Game.story.BindExternalFunction("var_from_input", self, "var_from_input")
	Game.story.BindExternalFunction("force_map", self, "force_map")
	Game.story.Continue()

func _on_story_continued(_text: String, tags: PoolStringArray) -> void:
	for tag in tags:
		if tag.begins_with("location:"):
			var loc = Location.load_from_name(tag.trim_prefix("location:").strip_edges())
			location_label.text = loc.display_name
			background.texture = loc.background
			
func force_map() -> void:
	get_tree().change_scene("res://scenes/Map.tscn")

# Display the input popup to get input from the user. 
func var_from_input(prompt: String, var_name: String) -> void:
	var popup: TextInputPopup = TextInputPopup.instance().init(var_name, prompt)
	add_child(popup)
	popup.popup_centered()
