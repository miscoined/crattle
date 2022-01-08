extends Node

signal dialogue_advanced
signal dialogue_participants_changed
signal location_changed
signal story_commanded

const InkStory = preload("res://addons/paulloz.ink/InkStory.cs")

const ACTION_PREFIX = ">>>"
const LOCATION_PREFIX = "location:"
const CHARACTER_PREFIX = "characters:"
const EXPRESSION_FACE_PREFIX = "face_"
const EXPRESSION_POSE_PREFIX = "pose_"

onready var story: InkStory = $InkStory

var current_dialogue: String
var current_speaker: Character

func _ready():
	var _err = story.connect("InkContinued", self, "_on_continue")
	story.SetVariable("merchant", Game.player.name)
	story.SetVariable("homesteader", Game.twin.name)

func bind_external_function(external_func_name: String, obj: Object, internal_func_name: String):
	story.BindExternalFunction(external_func_name, obj, internal_func_name)

func choose_path_string(path: String):
	story.ChoosePathString(path)

func get_variable(var_name):
	return story.GetVariable(var_name)

func set_variable(var_name, value):
	return story.SetVariable(var_name, value)

func advance():
	story.Continue()

func _on_continue(text: String, tags: PoolStringArray):
	var should_signal_dialogue = false

	var speaker = null
	if text.begins_with(ACTION_PREFIX):
		emit_signal("story_commanded", text.trim_prefix(ACTION_PREFIX).strip_edges())
	else:
		if ":" in text:
			var s = text.split(":", true, 1)
			speaker = Character.load_from_name(s[0])
			text = s[1].strip_edges()
		current_speaker = speaker
		current_dialogue = text
		should_signal_dialogue = true

	for tag in tags:
		tag = tag.strip_edges()
		if tag.begins_with(LOCATION_PREFIX):
			emit_signal(
				"location_changed",
				Location.load_from_name(tag.trim_prefix(LOCATION_PREFIX).strip_edges()))
		elif tag.begins_with(CHARACTER_PREFIX):
			var characters = []
			for char_ident in tag.trim_prefix(CHARACTER_PREFIX).strip_edges().split(" "):
				if char_ident == Game.player.ident or not char_ident:
					continue
				characters.append(Character.load_from_name(char_ident))
			emit_signal("dialogue_participants_changed", characters)
		elif tag.begins_with(EXPRESSION_FACE_PREFIX) or tag.begins_with(EXPRESSION_POSE_PREFIX):
			var target_ident = speaker.ident if speaker else Game.player.ident
			if ":" in tag:
				tag = tag.split(":", true, 1)
				target_ident = tag[1]
				tag = tag[0]
				
			var target_char = Character.load_from_name(target_ident)
			if tag.begins_with(EXPRESSION_FACE_PREFIX):
				target_char.expression_face = tag.trim_prefix(EXPRESSION_FACE_PREFIX)
			elif tag.begins_with(EXPRESSION_POSE_PREFIX):
				target_char.expression_pose = tag.trim_prefix(EXPRESSION_POSE_PREFIX)

	if should_signal_dialogue:
		emit_signal("dialogue_advanced", text, speaker)
