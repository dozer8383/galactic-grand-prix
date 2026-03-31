extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if globals.raceType == globals.grandPrix:
		var opponents = load("res://track_"+str(globals.currenttrackid+1)+"_ai.tscn")
		var instance = opponents.instantiate()
		add_child(instance)
