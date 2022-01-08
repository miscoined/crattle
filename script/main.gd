extends Control

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")

export(String) var starting_knot = "intro"

func _ready():
	Story.choose_path_string(starting_knot)
	get_tree().change_scene("res://scenes/Cutscene.tscn")
