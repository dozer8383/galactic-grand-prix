extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("VBoxContainer/BronzeLeague").grab_focus()


func _on_bronze_league_pressed() -> void:
	globals.currenttrackid = 0
	globals.raceType = globals.grandPrix
	get_tree().change_scene_to_file("res://game.tscn")


func _on_silver_league_pressed() -> void:
	#globals.currenttrackid = 5
	#globals.raceType = globals.grandPrix
	#get_tree().change_scene_to_file("res://game.tscn")
	pass


func _on_gold_league_pressed() -> void:
	#globals.currenttrackid = 10
	#globals.raceType = globals.grandPrix
	#get_tree().change_scene_to_file("res://game.tscn")
	pass
