extends Node

var character = load("res://characters/Vivia.tres")
var twin_character = load("res://characters/Vidal.tres")
var lula_character = load("res://characters/Lula.tres")

func _init():
	character.ident = "merchant"
	twin_character.ident = "homesteader"
