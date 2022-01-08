tool
extends Tree

var cargo_tree_items = {}

func _ready():
	var cargo
	if Engine.editor_hint:
		cargo = {load("res://cargo/Medicine.tres"): 20, load("res://cargo/Medicine2.tres"): 4}
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

func highlight_medicine():
	# TODO for now we hardcode medicine as the first entry in the list
	for col in range(columns):
		cargo_tree_items[0].select(col)
