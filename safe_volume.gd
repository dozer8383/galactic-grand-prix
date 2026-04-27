extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		if body.safe: print("already")
		print("safe!")
		$/root/Game/player.safe = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "player":
		if !body.safe: print("already")
		print("not safe!")
		$/root/Game/player.safe = false
