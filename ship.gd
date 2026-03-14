extends CharacterBody3D

const enginepower = 7
const turnSpeed = 0.5
var speed = 0
var turnVel = 0
var drift = Vector3.ZERO
var enginerpm = 0

func getInput(delta: float):
	var moveInput = Input.get_axis("backward", "forward")
	var turnInput = Input.get_axis("turnRight", "turnLeft")
	enginerpm += moveInput/160
	speed = enginerpm * enginepower
	velocity = -transform.basis.z * speed
	drift += velocity
	velocity = (velocity+drift).normalized()*speed
	turnVel += turnSpeed * turnInput
	rotate_y(turnVel * delta)
	
	turnVel *= 0.8
	drift *= 0.975
	enginerpm *= 0.99
	
	#$"../Control/DebugLabel".text = str(abs(velocity.normalized()-drift.normalized()) > Vector3(0.1,0,0.1))
	#$"../Control/DebugLabel".text = str(abs(velocity.normalized()-drift.normalized()))
	if is_on_wall():
		drift += get_wall_normal()*speed*30
		enginerpm *= 0.9
		rotation.z = move_toward(rotation.z, get_wall_normal().x+get_wall_normal().z,delta)
		$ray.rotation.x = move_toward($ray.rotation.x, get_wall_normal().x+get_wall_normal().z,delta)
	if Input.is_action_just_pressed("forward"):
		drift = Vector3.ZERO
		
	$ray.rotation.x = move_toward($ray.rotation.x,-turnInput*0.1,delta*0.3)
	rotation.z = move_toward(rotation.z,turnInput*0.02,delta*0.05)
	$"../Control/Speedometer".text = str(int(floor(abs(speed)*80)))

func _physics_process(delta: float) -> void:
	getInput(delta)
	move_and_slide()
