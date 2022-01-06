extends Node

var player: Character = load("res://characters/Vivia.tres")
var twin: Character = load("res://characters/Vidal.tres")
var lula: Character = load("res://characters/Lula.tres")

func _init():
	player.ident = "merchant"
	twin.ident = "homesteader"
