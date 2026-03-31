extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("VBoxContainer/GrandPrixButton").grab_focus()
	globals.raceType = 0
	globals.raceStarted = false


func _on_time_trial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://trackselect.tscn")


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_grand_prix_button_pressed() -> void:
	get_tree().change_scene_to_file("res://grandprixmenu.tscn")


func _on_controls_button_pressed() -> void:
	get_tree().change_scene_to_file("res://controls.tscn")
