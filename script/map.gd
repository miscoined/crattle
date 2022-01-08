tool
extends Control

export(Texture) var map_texture: Texture

onready var map: TextureRect = $VBoxContainer/HBoxContainer/Map
onready var dialogue: Dialogue = $Dialogue
onready var cargo_list: Tree = $VBoxContainer/HBoxContainer/Panel/VSplitContainer/CargoList

func _ready():
	map.texture = map_texture
	if not Engine.editor_hint:
		Story.advance()
