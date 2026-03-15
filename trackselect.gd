extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_track_selected() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _on_bronze_tracks_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	globals.currenttrackid = index
	get_tree().change_scene_to_file("res://game.tscn")
