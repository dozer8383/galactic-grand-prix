extends Area3D

signal validateLap

func _on_body_entered(body: Node3D) -> void:
	if body.name == "ray":
		validateLap.emit()
