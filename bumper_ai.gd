extends CharacterBody3D

var speed = 0
var enginerpm = 0
var enginepower = 0
var randomwait = 0
var oldangle = 0
var skill = 0
var start_time = 0
var lap = 0
var finished = false
var timerStarted = false
var hVelocity = 0
var yvel = 0

func _ready() -> void:
	randomwait = int(randf()*60)
	$"../Area3D".connect("body_entered",collided)
	
func collided(body: Node3D) -> void:
	if body.name == "player":
		randomwait = 30
		enginerpm *= 0.8
		$Thrust.light_energy = 0
		$Thrust2.light_energy = 0

func _physics_process(delta: float) -> void:
	$Thrust.light_energy = 0.1
	$Thrust2.light_energy = 0.1
	if globals.timerStarted or globals.raceStarted:
		if randomwait <= 0:
			enginerpm += 0.0047
		else:
			randomwait -= 1
			$Thrust.light_energy = 0
			$Thrust2.light_energy = 0
	if finished:
		$"..".rotation.y += 0.06
		$"..".position.y += 0.015
	else:
		if abs(angle_difference($"..".rotation.y,oldangle)) >= 0.015:
			enginerpm *= 1-(abs(angle_difference($"..".rotation.y,oldangle))*0.2)
			$Thrust.light_energy = 0
			$Thrust2.light_energy = 0
		oldangle = $"..".rotation.y
		enginepower = 4.5+speed/4.0
		speed = enginerpm * enginepower
		enginerpm *= 0.995
		$"..".progress += speed*delta*1.5
	$"../EngineNoise".pitch_scale = speed+6
	var globalpos2 = Vector2(global_position.x,global_position.z)
	for body in $"../..".get_children():
		if body != $"..":
			if body.name.contains("bumper"):
				var bodyglobalpos2 = Vector2(body.global_position.x,body.global_position.z)
				if global_position.distance_to(body.global_position) < 0.7:
					if abs(globalpos2.angle_to_point(bodyglobalpos2)) < (PI/4):
						randomwait = 10
	position.y += yvel
	if position.y < 0:
		position.y = 0
		yvel = 0
	else:
		yvel -= 0.0009
