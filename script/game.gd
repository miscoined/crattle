extends Node

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")

export(Resource) var player
export(Resource) var twin
export(Resource) var lula

var cargo = {load("res://cargo/Medicine.tres"): 20, load("res://cargo/Medicine2.tres"): 4}

onready var story: InkStory = $InkStory

func _ready():
	player.ident = "merchant"
	twin.ident = "homesteader"
