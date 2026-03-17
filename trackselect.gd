extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("HBoxContainer/MarginContainer/VBoxContainer/BronzeTracks").grab_focus()

func _on_track_selected() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _on_bronze_tracks_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	globals.currenttrackid = index
	get_tree().change_scene_to_file("res://game.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://game.tscn")

func _on_bronze_tracks_item_selected(index: int) -> void:
	globals.currenttrackid = index
