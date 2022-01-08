tool
extends Panel
class_name CargoSummaryEntry

export(Resource) var type setget _type_set
export(StyleBox) var highlight_style: StyleBox
var count := 0
var original_style: StyleBox

onready var icon: TextureRect = $HBoxContainer/Icon
onready var name_label: Label = $HBoxContainer/Label
onready var count_label: Label = $HBoxContainer/Count

func _ready():
	icon.texture = type.icon
	name_label.text = type.display_name
	count_label.text = "%s" % count
	original_style = get_stylebox("panel")

func init(type: CargoType, count: int):
	self.type = type
	self.count = count
	return self

func highlight():
	add_stylebox_override("panel", highlight_style)

func unhighlight():
	add_stylebox_override("panel", original_style)

func _type_set(res: Resource):
	assert(res is CargoType)
	type = res
