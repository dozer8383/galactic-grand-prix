extends Node3D

var overallPlace = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("podiumCameraIntro")
	if globals.points > 48:
		overallPlace = 1
	elif globals.points > 32:
		overallPlace = 2
	else:
		overallPlace = 3
	if globals.bestPoints[globals.currentprix] < globals.points:
		globals.bestPoints[globals.currentprix] = globals.points
		globals.saveGame()
	match overallPlace:
		1:
			$Display/PlaceStylized.text = "1"
			$Display/VBoxContainer/Place.text = "1st PLACE"
			$pedestal.position = Vector3(4.57,1.76,-11.3)
		2:
			$Display/PlaceStylized.text = "2"
			$Display/VBoxContainer/Place.text = "2nd PLACE"
			$pedestal.position = Vector3(4.57,1.71,-11.1)
		3:
			$Display/PlaceStylized.text = "3"
			$Display/VBoxContainer/CongratulatoryMessage.text = "TRY AGAIN"
			$Display/VBoxContainer/Place.text = "3rd PLACE"
			$pedestal.position = Vector3(4.57,1.66,-11.5)
	$Display/VBoxContainer/Points.text = str(globals.points)+" POINTS"

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	$Display.show()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("forward"):
		get_tree().change_scene_to_file("res://mainmenu.tscn")
