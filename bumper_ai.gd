extends PathFollow3D

var speed = 0
var enginerpm = 0
var enginepower = 0
var randomwait = 0
var oldangle = 0
var skill = 0

func _ready() -> void:
	randomwait = int(randf()*30)

func _physics_process(_delta: float) -> void:
	if globals.timerStarted or globals.raceStarted:
		if randomwait <= 0:
			enginerpm += 0.005
		else:
			randomwait -= 1
	if abs(angle_difference(rotation.y,oldangle)) >= 0.028:
		enginerpm *= 0.98
		$dummyShip/Thrust.light_energy = 0
		$dummyShip/Thrust2.light_energy = 0
	else:
		$dummyShip/Thrust.light_energy = 0.1
		$dummyShip/Thrust2.light_energy = 0.1
	oldangle = rotation.y
	enginepower = 4.5+speed/4.0
	speed = enginerpm * enginepower
	enginerpm *= 0.9952
	progress_ratio += speed/4000
