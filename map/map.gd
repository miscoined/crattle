tool
extends Control

export(Texture) var map_texture: Texture

onready var map: TextureRect = $VBoxContainer/HBoxContainer/Map
onready var dialogue: Dialogue = $Dialogue

func _ready():
	map.texture = map_texture
	var _err = Story.connect("story_commanded", self, "_on_story_command")
	if not Engine.editor_hint:
		dialogue.update_dialogue(Story.current_dialogue, Story.current_speaker)
