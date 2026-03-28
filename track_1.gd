extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if globals.raceType == globals.grandPrix:
		var opponents = preload("res://track_1_ai.tscn")
		var instance = opponents.instantiate()
		add_child(instance)
