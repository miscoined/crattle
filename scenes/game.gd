extends Node

export(Resource) var player
export(Resource) var twin
export(Resource) var lula

var cargo = {load("res://cargo/item/Medicine.tres"): 20, load("res://cargo/item/Medicine2.tres"): 4}

func _ready():
	player.ident = "merchant"
	twin.ident = "homesteader"
