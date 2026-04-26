extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("ScrollContainer/VBoxContainer/HBoxContainer/VBoxContainer/Track1").grab_focus()

func _on_track_selected() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
