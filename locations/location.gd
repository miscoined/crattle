extends Resource
class_name Location

const PLACEHOLDER_BG: Texture = preload("img/placeholder.png")

export(Texture) var background: Texture = null setget ,background_get
export(String) var display_name

static func load_from_name(name: String) -> Location:
	return load("res://locations/%s.tres" % name) as Location
	
func background_get() -> Texture:
	if not background:
		return PLACEHOLDER_BG
	return background
