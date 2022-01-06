tool
extends Control

export(Texture) var map_texture: Texture

onready var map: TextureRect = $Map

func _ready():
	map.texture = map_texture
