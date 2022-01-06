extends Control

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")
const TextInputPopup = preload("res://scenes/TextInputPopup.tscn")

export(String) var starting_knot = "intro_caravan"

var _input_var_name = ""

onready var story: InkStory = $InkStory
onready var dialogue: Dialogue = $Dialogue
onready var background: TextureRect = $Background
onready var location_label: Label = $LocationNameLabel

func _ready():
	var _err = story.connect("InkContinued", self, "_on_story_continued")
	
	story.SetVariable("merchant", Player.character.name)
	story.SetVariable("homesteader", Player.twin_character.name)
	
	story.BindExternalFunction("var_from_input", self, "var_from_input")
	story.BindExternalFunction("force_map", self, "force_map")
	
	story.ChoosePathString(starting_knot)

	story.Continue()

func _on_story_continued(_text: String, tags: PoolStringArray) -> void:
	for tag in tags:
		if tag.begins_with("location:"):
			set_location(tag.trim_prefix("location:").strip_edges())

func set_location(location_name: String) -> void:
	var loc = Location.load_from_name(location_name)
	location_label.text = loc.display_name
	background.texture = loc.background

# Display the input popup to get input from the user. 
func var_from_input(prompt: String, var_name: String) -> void:
	_input_var_name = var_name
	var popup: TextInputPopup = TextInputPopup.instance().init(prompt, story.GetVariable(var_name))
	add_child(popup)
	var _err := popup.connect("input_entered", self, "_on_question_answered")
	dialogue.can_advance = false
	popup.popup_centered()

func _on_question_answered(s: String, popup: TextInputPopup):
	if not s:
		s = popup.default
	if _input_var_name == "lula":
		Player.lula_character.name = s
	story.SetVariable(_input_var_name, s)
	popup.hide()
	dialogue.can_advance = true
	popup.queue_free()
