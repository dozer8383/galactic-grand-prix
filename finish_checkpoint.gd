extends Area3D

var playerCount = 0
var botCount = 0
signal finishcrossed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.name == "ray":
		print("start")
		finishcrossed.emit()
		playerCount += 1
	if body.name == "dummyShip":
		body.lap += 1
		if body.lap > 4:
			body.finished = true
			globals.botFinishes += 1
