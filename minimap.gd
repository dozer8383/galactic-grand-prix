extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match globals.shipChoice:
		0:
			$PlayerIcon.texture = load("res://graphics/ray.png")
		1:
			$PlayerIcon.texture = load("res://graphics/vector.png")
		2:
			$PlayerIcon.texture = load("res://graphics/tracer.png")
	texture = load("res://graphics/track"+str(globals.currenttrackid+1)+".png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PlayerIcon.position = Vector2(
		remap($"/root/Game/player".position.x,-20,20,0,196)-10,
		remap($"/root/Game/player".position.z,-20,20,0,196)-10)
