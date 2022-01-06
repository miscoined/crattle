extends Panel

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")

# The variable name of the current input. If empty, there is no input waiting
# to be entered.
var _input_var_name := ""

onready var story := $InkStory
onready var locationLabel = $LocationNameLabel
onready var speechbox = $VBoxContainer/MarginContainer/SpeechBox
onready var speakerLabel = $VBoxContainer/MarginContainer/SpeechBox/SpeakerNameLabel
onready var playerPortrait = $PlayerPortrait
onready var participantContainer = $VBoxContainer/Participants
onready var participantPortraitTemplate = $VBoxContainer/Participants/ParticipantPortraitTemplate.duplicate()
onready var speechTextLabel = $VBoxContainer/MarginContainer/SpeechBox/PanelContainer/SpeechTextLabel
onready var popupQuestionLabel = $InputPopup/VBoxContainer/QuestionLabel
onready var popupAnswerInput = $InputPopup/VBoxContainer/AnswerInput

func _ready():
	# Make speaker name display above speech text box
	VisualServer.canvas_item_set_z_index(speakerLabel.get_canvas_item(), 1)
	
	popupAnswerInput.connect("text_entered", self, "_on_text_entered")
	speechbox.connect("gui_input", self, "_on_speechbox_gui_input")
	
	story.SetVariable("merchant", Player.character.name)
	story.SetVariable("homesteader", Player.twin_character.name)
	
	story.BindExternalFunction("var_from_input", self, "var_from_input")

	advance()

func _input(event):
	if event.is_action_released("ui_accept") and not _input_var_name:
		advance()

func advance() -> void:
	if not story.get_CanContinue():
		return

	var s = story.Continue()

	var speaker = null
	if ":" in s:
		s = s.split(":", true, 1)
		speaker = Character.load_from_name(s[0])
		s = s[1].strip_edges()
	print("%s %s" % [speaker.name if speaker else "", story.get_CurrentTags()])

	for tag in story.get_CurrentTags():
		if tag.begins_with("characters:"):
			set_participants(tag.trim_prefix("characters:").strip_edges().split(" "))
		if tag.begins_with("location:"):
			set_location(tag.trim_prefix("location:").strip_edges())
		if tag.begins_with("face_") or tag.begins_with("pose_"):
			var target = speaker.ident if speaker else Player.character.ident
			if ":" in tag:
				tag = tag.split(":", true, 1)
				target = tag[1]
				tag = tag[0]
				
			var target_char = Character.load_from_name(target)
			if tag.begins_with("face_"):
				target_char.expression_face = tag.trim_prefix("face_")
			elif tag.begins_with("pose_"):
				target_char.expression_pose = tag.trim_prefix("pose_")
	
	playerPortrait.update_portrait()
	for portrait in participantContainer.get_children():
		assert(portrait is CharacterPortrait)
		portrait.update_portrait()

	speechTextLabel.bbcode_text = s
	speakerLabel.text = speaker.display_name if speaker else ""

# Display the portraits of the participants from an array of character names
func set_participants(participant_names: Array) -> void:
	for child in participantContainer.get_children():
		participantContainer.remove_child(child)
		child.queue_free()  # TODO Is this necessary?

	if participant_names == [""]:
		return
	
	for name in participant_names:
		if name == Player.character.ident:  # Don't show the player character ever
			continue
		var portrait = participantPortraitTemplate.duplicate()
		portrait.character = Character.load_from_name(name)
		participantContainer.add_child(portrait)
		portrait.show()

func set_location(location_name: String) -> void:
	var loc = Location.load_from_name(location_name)
	locationLabel.text = loc.display_name
	var stylebox = StyleBoxTexture.new()
	stylebox.texture = loc.background
	add_stylebox_override("panel", stylebox)

# Display the input popup to get input from the user. 
func var_from_input(prompt: String, var_name: String) -> void:
	popupAnswerInput.placeholder_text = story.GetVariable(var_name)
	popupQuestionLabel.text = prompt
	_input_var_name = var_name
	$InputPopup.popup_centered()

func _on_text_entered(s: String):
	if not s:
		s = popupAnswerInput.placeholder_text
	if _input_var_name == "lula":
		Player.lula_character.name = s
	story.SetVariable(_input_var_name, s)
	$InputPopup.hide()
	_input_var_name = ""

func _on_speechbox_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		advance()
