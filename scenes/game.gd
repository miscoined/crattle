extends Node

export(Resource) var player
export(Resource) var twin
export(Resource) var lula

func _ready():
	player.ident = "merchant"
	twin.ident = "homesteader"
