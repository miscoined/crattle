tool
extends Control

const cargo1 = preload("item/Medicine.tres")
const cargo2 = preload("item/Food.tres")

var cargo_tree_items = {}

func _ready():
	var cargo
	if Engine.editor_hint:
		cargo = {cargo1: 20, cargo2: 4}
	else:
		cargo = Game.cargo
	var root = create_item()
	for item in cargo:
		var child = create_item()
		child.set_icon(0, item.icon)
		child.set_text(1, item.display_name)
		child.set_text(2, "%s" % cargo[item])
		for col in range(columns):
			child.set_selectable(col, false)
		cargo_tree_items[item] = child
	highlight_medicine()

func highlight_medicine():
	# TODO for now we hardcode medicine
	cargo_tree_items[cargo1].set_selectable(0, true)
	cargo_tree_items[cargo1].select(0)
