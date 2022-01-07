tool
extends Control

export(Texture) var map_texture: Texture

onready var map: TextureRect = $VBoxContainer/HBoxContainer/Map
onready var dialogue: Dialogue = $Dialogue

func _ready():
	map.texture = map_texture
	if not Engine.editor_hint:
		dialogue._on_story_continued(Game.story.get_CurrentText(), Game.story.get_CurrentTags())
