extends PopupPanel
class_name TextInputPopup
# A popup with a single line input that sends a signal with the contents once
# the input has been completed.

signal input_entered

var prompt: String
var default: String

onready var question_label: Label = $VBoxContainer/QuestionLabel
onready var answer_input: LineEdit = $VBoxContainer/AnswerInput

func _ready():
	question_label.text = prompt
	answer_input.placeholder_text = default

	answer_input.connect("text_entered", self, "_signal_input_entered")

func init(prompt="Question?", default="Answer"):
	self.prompt = prompt
	self.default = default
	return self

func _signal_input_entered(s: String) -> void:
	emit_signal("input_entered", s, self)	
