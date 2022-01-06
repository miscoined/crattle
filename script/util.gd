tool
extends Object
# Utility script of static functions

# Wrapper around load() that loads the fallback resource if the original one is not present.
static func load(res_path: String, fallback) -> Resource:
	#assert(fallback is String or fallback is Resource)

	if ResourceLoader.exists(res_path):
		return load(res_path)
	if fallback is String:
		return load(fallback)
	return fallback

# Hide a node if running in editor, or free it otherwise.
static func hide_or_free(node: Node) -> void:
	if Engine.editor_hint:
		node.hide()
	else:
		node.queue_free()
