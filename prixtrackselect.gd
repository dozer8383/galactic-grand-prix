extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("VBoxContainer/HBoxContainer/BronzeLeague").grab_focus()
	$VBoxContainer/HBoxContainer/BronzePoints.text = str(int(globals.bestPoints[0]))+" POINTS"
	$VBoxContainer/HBoxContainer2/SilverPoints.text = str(int(globals.bestPoints[1]))+" POINTS"

func _on_bronze_league_pressed() -> void:
	globals.currenttrackid = 0
	globals.currentprix = 0
	globals.raceType = globals.grandPrix
	get_tree().change_scene_to_file("res://game.tscn")


func _on_silver_league_pressed() -> void:
	globals.currenttrackid = 5
	globals.currentprix = 1
	globals.raceType = globals.grandPrix
	get_tree().change_scene_to_file("res://game.tscn")


func _on_gold_league_pressed() -> void:
	#globals.currenttrackid = 10
	#globals.currentprix = 2
	#globals.raceType = globals.grandPrix
	#get_tree().change_scene_to_file("res://game.tscn")
	pass
