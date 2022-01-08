tool
extends Resource
class_name Character

export(String) var ident
export(String) var name
export(String) var display_name
export(Texture) var default_face = preload("res://dialogue/character/img/placeholder-face.png")
export(Texture) var default_pose = preload("res://dialogue/character/img/placeholder-pose.png")

const Emotion = preload("emotions.gd")
const Util = preload("res://script/util.gd")

var expression_face := "neutral"
var expression_pose := "neutral"

func portrait_head() -> Texture:
	return _load_expression(expression_face, "face")
		
func portrait_body() -> Texture:
	return _load_expression(expression_pose, "pose")

static func load_from_name(name: String) -> Character:
	if name.to_lower() == Game.twin.ident:
		return Game.twin
	if name.to_lower() == Game.player.ident:
		return Game.player
	return Util.load(
		"res://dialogue/character/characters/%s.tres" % name.capitalize(),
		"res://dialogue/character/characters/Placeholder.tres") as Character

func _load_expression(expression: String, type: String) -> Texture:
	return Util.load(
		"res://dialogue/character/img/%s-%s-%s.png" % [name.to_lower(), type, expression.replace("_", "-")],
		null) as Texture
