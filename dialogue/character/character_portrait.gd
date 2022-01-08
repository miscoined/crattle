tool
extends Control
class_name CharacterPortrait

export(Resource) var character setget character_set
export(Font) var placeholderTextFont = null

onready var portrait := $Portrait
onready var expressionLabel := $ExpressionLabel

func _ready():
	if not placeholderTextFont:
		placeholderTextFont = load("res://font/DefaultFont.tres")
	update_portrait()

func character_set(res: Resource) -> void:
	assert(res is Character)
	character = res as Character

func update_portrait() -> void:
	var expression_text = ""

	var head: Texture = character.portrait_head()
	if not head:
		head = character.default_face
		expression_text += character.expression_face  
	if not head:
		head = load("res://dialogue/character/img/placeholder-face.png")
	
	var body: Texture = character.portrait_body()
	if not body:
		body = character.default_pose
		expression_text += "\n" + character.expression_pose
	if not body:
		body = load("res://dialogue/character/img/placeholder-pose.png")

	assert(head.get_size() == body.get_size())
	
	var portrait_img := head.get_data().duplicate()
	portrait_img.blend_rect(
		body.get_data(), Rect2(Vector2.ZERO, body.get_size()), Vector2.ZERO)
	
	var portrait_tex = ImageTexture.new()
	portrait_tex.create_from_image(portrait_img)
	portrait.texture = portrait_tex

	expressionLabel.text = expression_text.strip_edges()
