extends CharacterBody3D

const enginepower = 5
const turnSpeed = 0.5
var speed = 0
var turnVel = 0
var drift = Vector3.ZERO
var enginerpm = 0

func getInput(delta: float):
	var moveInput = Input.get_axis("backward", "forward")
	var turnInput = Input.get_axis("turnRight", "turnLeft")
	enginerpm += moveInput/100
	speed = enginerpm * enginepower
	velocity = -transform.basis.z * speed
	drift += velocity
	velocity = (velocity+drift*5).normalized()*speed
	turnVel += turnSpeed * turnInput
	rotate_y(turnVel * delta)
	turnVel *= 0.8
	drift *= 0.95
	enginerpm *= 0.99
	#$"../Control/Label".text = str(abs(velocity.normalized()-drift.normalized()) > Vector3(0.1,0,0.1))
	$"../Control/Label".text = str(abs(velocity.normalized()-drift.normalized()))
	if is_on_wall():
		drift = drift.bounce(get_wall_normal())
		speed = -speed
	if Input.is_action_just_pressed("forward"):
		drift = Vector3.ZERO

func _physics_process(delta: float) -> void:
	getInput(delta)
	move_and_slide()
