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
@onready var player = $"../../../../../player"

func _ready() -> void:
	randomwait = int(randf()*60)
	$"../Area3D".connect("body_entered",collided)
	
func collided(body: Node3D) -> void:
	if body.name == "player":
		randomwait = 30
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
		if abs(angle_difference($"..".rotation.y,oldangle)) >= 0.01:
			enginerpm *= 1-(abs(angle_difference($"..".rotation.y,oldangle))*0.2)
			$Thrust.light_energy = 0
			$Thrust2.light_energy = 0
		oldangle = $"..".rotation.y
		enginepower = 4.5+speed/4.0
		speed = enginerpm * enginepower
		enginerpm *= 0.995
		hVelocity *= 0.97
		if is_on_wall():
			hVelocity += get_wall_normal().normalized().x
			enginerpm = 0
			print(get_wall_normal())
		#$"..".h_offset -= hVelocity
		$"..".progress += speed*delta*1.5
	for body in $"../..".get_children():
		if body != $"..":
			if body.name.contains("bumper"):
				if global_position.distance_to(body.global_position) < 0.5:
					if abs(global_position.signed_angle_to(body.global_position,Vector3(0,1,0))) < (PI/6):
						randomwait = 10
