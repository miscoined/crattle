extends Reference

const NEUTRAL = "neutral"
const CONFUSED = "confused"
const ANGRY = "angry"
const SMUG = "smug"

static func from_string(s: String):
	match s:
		"neutral":
			return NEUTRAL
		"confused":
			return CONFUSED
		"angry":
			return ANGRY
		"smug":
			return SMUG
	return NEUTRAL
