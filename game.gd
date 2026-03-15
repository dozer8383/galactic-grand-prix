extends Node3D

var trackscene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match globals.currenttrackid:
		0:
			trackscene = preload("res://track_1.tscn")
		1:
			trackscene = preload("res://track_2.tscn")
	var track = trackscene.instantiate()
	add_child(track)
