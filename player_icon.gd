extends TextureRect


func _process(delta: float) -> void:
	position = Vector2(
		remap($"/root/Game/player".position.x,-20,20,0,196)-10,
		remap($"/root/Game/player".position.z,-20,20,0,196)-10)
