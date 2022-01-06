tool
extends Resource
class_name Character

export(String) var ident
export(String) var name
export(String) var display_name
export(Texture) var default_face
export(Texture) var default_pose
export(Vector2) var face_offset

const Emotion = preload("res://script/emotions.gd")
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
		"res://characters/%s.tres" % name.capitalize(),
		"res://characters/Placeholder.tres") as Character

func _load_expression(expression: String, type: String) -> Texture:
	return Util.load(
		"res://img/character/%s-%s-%s.png" % [name.to_lower(), type, expression.replace("_", "-")],
		null) as Texture
