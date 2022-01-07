extends Control

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")

export(String) var starting_knot = "intro"

onready var story: InkStory = Game.story

func _ready():	
	Game.story.SetVariable("merchant", Game.player.name)
	Game.story.SetVariable("homesteader", Game.twin.name)

	Game.story.ChoosePathString(starting_knot)

	get_tree().change_scene("res://scenes/Cutscene.tscn")
