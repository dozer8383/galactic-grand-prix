extends Node3D

var tempBestTime = 0
var trackscene
signal crossedfinish
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.timerStarted = false
	match globals.currenttrackid:
		0:
			trackscene = preload("res://track_1.tscn")
		1:
			trackscene = preload("res://track_2.tscn")
		2:
			trackscene = preload("res://track_3.tscn")
	var track = trackscene.instantiate()
	add_child(track)
	$"track/FinishCheckpoint".connect("finishcrossed",newLap)
	for node in $track.get_children():
		if node.name.contains("rough"):
			node.connect("shipOnRough",$ray.onRough)
		if node.name.contains("speed"):
			node.connect("shipOnSpeed",$ray.onSpeed)

func newLap() -> void:
	if globals.timerGet() < tempBestTime or tempBestTime == 0:
		tempBestTime = globals.timerGet()
	globals.timerStart()
	crossedfinish.emit()

func _process(delta: float) -> void:
	var currenttime = globals.timerGet()
	$gui/Time.text = "%01d:%02d.%03d" % [currenttime/60000,(currenttime/1000)%60,currenttime%1000]
	$gui/BestTime.text = "BEST  %01d:%02d.%03d" % [tempBestTime/60000,(tempBestTime/1000)%60,tempBestTime%1000]

func _on_crash() -> void:
	$gui.hide()
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
