extends Area3D

signal jumpShip

func _ready() -> void:
	#jumpShip.connect($/root/Game/player.jump)
	pass

func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		body.yvel = 0.038
	if body.name == "dummyShip":
		body.yvel = 0.038
