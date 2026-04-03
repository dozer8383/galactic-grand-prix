extends CharacterBody3D

var enginepower = 5
const turnSpeed = 0.3
var speed = 0
var thrust = 0
var turnVel = 0
var drift = Vector3.ZERO
var enginerpm = 0
var power = 100
var addPower = 0
var crashed = false
var canStart = false
var thrustcolor = Vector3.ZERO
var raceFinished = false
var canMove = false
var shipVisual
signal crash
signal showHud

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
	
	enginepower = 4.5+speed/4.0
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
		shipVisual.rotation.x = move_toward(shipVisual.rotation.x, get_wall_normal().x+get_wall_normal().z,delta)
		
	shipVisual.rotation.x = move_toward(shipVisual.rotation.x,-turnInput*0.1,delta*0.3)
	rotation.z = move_toward(rotation.z,turnInput*0.02,delta*0.05)
	shipVisual.rotation.z = clamp((speed-5.5)*0.13,0,0.5)
	shipVisual.position.y = clamp((speed-6.5)*0.01,0,0.5)
	shipVisual.rotation.x = clamp(shipVisual.rotation.x,-3,3)
	position.y = 1.57
	$"../gui/hud/Speedometer".text = str(int(floor(abs(speed)*60)))
	$"../gui/hud/TextureProgressBar".value = power
	if Input.is_action_pressed("forward"):
		thrust = speed
	else:
		thrust = move_toward(thrust, 0, delta*5)
	$Thrust.light_energy = thrust/40
	$Thrust2.light_energy = thrust/40
	if Input.is_action_pressed("lookback"):
		$Camera3D.rotation.y = PI
		$Camera3D.position = Vector3(0,0.18,0)
	else:
		$Camera3D.rotation.y = 0
		$Camera3D.position = Vector3(0,0.26,0.2)

func _ready() -> void:
	$Camera3D.position.z = 15.2
	$Camera3D.position.y = 7.77
	match globals.shipChoice:
		0:
			$ray.show()
			shipVisual = $ray
		1:
			$vector.show()
			shipVisual = $vector
		2:
			$tracer.show()
			shipVisual = $tracer

func _physics_process(delta: float) -> void:
	if !raceFinished:
		if !canStart:
			$Camera3D.position.z = move_toward($Camera3D.position.z, 0.2, delta*8)
			$Camera3D.position.y = move_toward($Camera3D.position.y, 0.26, delta*4)
			if round($Camera3D.position.z*100)/100 == 0.2 and round($Camera3D.position.y*100)/100 == 0.26:
				canStart = true
				showHud.emit()
		else:
			if canMove:
				getInput(delta)
				move_and_slide()
				if addPower > 0:
					addPower -= 1
					power += 1
	else:
		$Camera3D.position = Vector3(0,1,1)

func onRough() -> void:
	enginerpm *= 0.99
	drift *= 0.98
	shipVisual.position.y -= 0.004*randf()+0.002

func onSpeed() -> void:
	enginerpm = 1.5
	drift *= 0.5
	
func raceStart() -> void:
	canMove = true

func _on_game_race_finish() -> void:
	raceFinished = true

func _on_game_crossedfinish() -> void:
	addPower += 35
