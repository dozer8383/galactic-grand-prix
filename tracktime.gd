extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if RenderingServer.get_current_rendering_method() == "gl_compatibility":
		show()
		
func _pressed() -> void:
	OS.shell_open("https://github.com/dozer8383/galactic-grand-prix/releases/latest")
