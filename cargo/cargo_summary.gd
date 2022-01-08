tool
extends VBoxContainer

const CargoType = preload("cargo_type.gd")
const CargoSummaryEntry = preload("CargoSummaryEntry.tscn")

const medicine = preload("item/Medicine.tres")
const food = preload("item/Food.tres")

var cargo = {
	"Medicine": CargoSummaryEntry.instance().init(medicine, 20),
	"Food": CargoSummaryEntry.instance().init(food, 5),
}

var has_highlight = false

func _ready():
	for entry in cargo.values():
		add_child(entry)

	if not Engine.editor_hint:
		Story.connect("story_commanded", self, "_on_story_command")

func highlight(cargo_type: String):
	has_highlight = true
	cargo[cargo_type].highlight()

func clear_highlight():
	if has_highlight:
		for entry in cargo.values():
			entry.unhighlight()

func _on_story_command(command: String):
	match command:
		"tut_highlight_meds":
			highlight("Medicine")
		"tut_highlight_meds_clear":
			clear_highlight()
