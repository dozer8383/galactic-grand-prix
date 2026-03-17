extends CharacterBody3D

const enginepower = 7
const turnSpeed = 0.3
var speed = 0
var turnVel = 0
var drift = Vector3.ZERO
var enginerpm = 0
var power = 100
var crashed = false
signal crash

func getInput(delta: float):
	var moveInput = Input.get_action_strength("forward")
	var turnInput = Input.get_axis("turnRight", "turnLeft")
	
	if power <= 0 and not crashed:
		crashed = true
		crash.emit()
	if power > 0:
		if power < 15:
			enginerpm += moveInput/200
		else:
			enginerpm += moveInput/170
		turnVel += turnSpeed * turnInput
	
	speed = enginerpm * enginepower
	velocity = -transform.basis.z * speed
	drift += velocity
	velocity = (velocity+(drift*clamp((speed-6.5)*1.3,0.03,0.7))).normalized()*speed
	turnVel = clamp(turnVel,-3,3)
	rotate_y(turnVel * delta)
	#drift *= (1-Input.get_action_strength("backward"))
	enginerpm *= (1-Input.get_action_strength("backward")*0.01)
	
	if power > 0:
		turnVel *= 0.95
	else:
		turnVel *= 0.99
	drift *= 0.98
	enginerpm *= 0.995
	power = clamp(power,0,100)
	
	if Input.is_action_just_pressed("forward") or Input.is_action_pressed("backward"):
		drift *= 0.85
		enginerpm *= 0.96
	
	#$"../Control/DebugLabel".text = str(abs(velocity.normalized()-drift.normalized()) > Vector3(0.1,0,0.1))
	#$"../gui/DebugLabel".text = str(clamp((speed-6.5)*1.3,0.03,0.7))
	#$"../gui/DebugLabel".text = str(enginerpm)
	
	if is_on_wall():
		power -= 0.8*speed
		drift += get_wall_normal()*speed*25
		turnVel += (get_wall_normal().x+get_wall_normal().z)/3
		enginerpm *= 0.9
		rotation.z = move_toward(rotation.z, get_wall_normal().x+get_wall_normal().z,delta)
		$ray.rotation.x = move_toward($ray.rotation.x, get_wall_normal().x+get_wall_normal().z,delta)
		
	$ray.rotation.x = move_toward($ray.rotation.x,-turnInput*0.1,delta*0.3)
	rotation.z = move_toward(rotation.z,turnInput*0.02,delta*0.05)
	$ray.rotation.z = clamp((speed-5.5)*0.13,0,0.5)
	$ray.position.y = clamp((speed-6.5)*0.01,0,0.5)
	$ray.rotation.x = clamp($ray.rotation.x,-3,3)
	$"../gui/Speedometer".text = str(int(floor(abs(speed)*60)))
	$"../gui/TextureProgressBar".value = power

func _physics_process(delta: float) -> void:
	getInput(delta)
	move_and_slide()

func onRough() -> void:
	enginerpm *= 0.99
	drift *= 0.98

func onSpeed() -> void:
	enginerpm = 1.7

func _on_crossedfinish() -> void:
	power += 20
