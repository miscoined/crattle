extends PopupPanel
class_name TextInputPopup
# A popup with a single line input

var prompt: String
var var_name: String

onready var question_label: Label = $VBoxContainer/QuestionLabel
onready var answer_input: LineEdit = $VBoxContainer/AnswerInput

func _ready():
	question_label.text = prompt
	answer_input.placeholder_text = Story.get_variable(var_name)

	var _err = answer_input.connect("text_entered", self, "_signal_input_entered")
	
	get_tree().paused = true

func init(var_name, prompt="Question?"):
	self.prompt = prompt
	self.var_name = var_name
	return self

func _signal_input_entered(s: String) -> void:
	if not s:
		s = answer_input.placeholder_text
	if var_name == "lula":
		Game.lula.name = s
	Story.set_variable(var_name, s)
	hide()
	get_tree().paused = false
	queue_free()
