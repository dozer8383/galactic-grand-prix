extends Node3D

var tempBestTime = 0
var trackscene
var lapValidated = false
var laps = 0
var place = 1
var addpoints = 0
var placeDisplay
var raceFinished = false

const retro = preload("res://retro.tres")
const retrogreen = preload("res://retro-green.tres")

signal crossedfinish
signal raceFinish
signal startRace
signal pauseGame

func _ready() -> void:
	globals.loadGame()
	tempBestTime = int(globals.bestTimes[globals.currenttrackid])
	globals.timerStarted = false
	globals.raceStarted = false
	globals.botFinishes = 0
	match globals.currenttrackid:
		0:
			trackscene = preload("res://track_1.tscn")
			$gui/TrackTitle.text = "MIASMA LAKE I"
		1:
			trackscene = preload("res://track_2.tscn")
			$gui/TrackTitle.text = "CRYSTAL PLATEAU I"
		2:
			trackscene = preload("res://track_3.tscn")
			$gui/TrackTitle.text = "DARKNESS"
		3:
			trackscene = preload("res://track_4.tscn")
			$gui/TrackTitle.text = "FIRE STORM I"
		4:
			trackscene = preload("res://track_5.tscn")
			$gui/TrackTitle.text = "LUMINOUS OCEAN"
	var track = trackscene.instantiate()
	add_child(track)
	$"track/FinishCheckpoint".connect("finishcrossed",newLap)
	$"track/MidCheckpoint".connect("validateLap",lapOK)
	for node in $track.get_children():
		if node.name.contains("rough"):
			node.connect("shipOnRough",$player.onRough)
		if node.name.contains("speed"):
			node.connect("shipOnSpeed",$player.onSpeed)
	$player.connect("showHud",introFinished)
	$player.connect("crash",_on_crash)
	connect("startRace",$player.raceStart)
	connect("pauseGame",$gui/pause.pause)
	if globals.raceType == globals.grandPrix:
		$gui/hud/Lap.show()
	if globals.raceType == globals.timeTrial:
		$gui/hud/BestTime.show()
	

func newLap() -> void:
	if lapValidated or !globals.timerStarted:
		if globals.timerStarted:
			if globals.timerGet() < tempBestTime or tempBestTime == 0:
				tempBestTime = globals.timerGet()
				globals.bestTimes[globals.currenttrackid] = tempBestTime
		globals.timerStart()
		crossedfinish.emit()
		globals.saveGame()
		lapValidated = false
		if globals.raceType == globals.grandPrix:
			laps += 1
			if laps == 5:
				raceFinish.emit()
				raceFinished = true
				place = 1+globals.botFinishes
				$gui/hud.hide()
				match place:
					1:
						placeDisplay = "1st"
						addpoints = 12
					2:
						placeDisplay = "2nd"
						addpoints = 8
					3:
						placeDisplay = "3rd"
						addpoints = 5
					4,5,6,7,8,9:
						placeDisplay = str(place)+"th"
						addpoints = 2
				globals.points += addpoints
				$gui/TrackTitle.text = placeDisplay+" position"
				$gui/PointsAdded.text = "+"+str(addpoints)+" points"
				$gui/Prompt.show()
				$gui/TrackTitle.show()
				$gui/PointsAdded.show()
			$gui/hud/Lap.text = "LAP "+str(max(1,laps))+"/4"

func lapOK() -> void:
	lapValidated = true

func _process(_delta: float) -> void:
	var currenttime = globals.timerGet()
	$gui/hud/Time.text = "%01d:%02d.%03d" % [currenttime/60000,(currenttime/1000)%60,currenttime%1000]
	if globals.raceType == globals.timeTrial:
		$gui/hud/BestTime.text = "BEST  %01d:%02d.%03d" % [tempBestTime/60000,(tempBestTime/1000)%60,tempBestTime%1000]
	if Input.is_action_just_pressed("pause") and globals.raceStarted:
		pauseGame.emit()

func _on_crash() -> void:
	$gui/hud.hide()
	if globals.raceType == globals.timeTrial:
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()
	elif globals.raceType == globals.grandPrix:
		$gui/Countdown.label_settings = retro
		$gui/Countdown.text = "ELIMINATED"
		$gui/Countdown.show()
		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()
		#globals.timerStarted = false
		#globals.raceStarted = false
		#globals.raceType = 0
		#get_tree().change_scene_to_file("res://grandprixmenu.tscn")
	
func introFinished() -> void:
	$gui/hud.show()
	$gui/TrackTitle.hide()
	$gui/Countdown.text = "READY"
	$gui/Countdown.show()
	if globals.raceType == 1:
		await get_tree().create_timer(2+(randf()*1.5)).timeout
	startRace.emit()
	globals.raceStarted = true
	$gui/Countdown.label_settings = retrogreen
	$gui/Countdown.text = "GO!!"
	await get_tree().create_timer(1).timeout
	$gui/Countdown.hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("forward") and raceFinished:
		globals.currenttrackid += 1
		if globals.currenttrackid % 5 == 0:
			globals.raceType = 0
			globals.timerStarted = false
			globals.raceStarted = false
			get_tree().change_scene_to_file("res://podium.tscn")
		else:
			get_tree().reload_current_scene()
	if event.is_action_pressed("cheat") and false:
		raceFinish.emit()
		raceFinished = true
		place = 1+globals.botFinishes
		$gui/hud.hide()
		match place:
			1:
				placeDisplay = "1st"
				addpoints = 12
			2:
				placeDisplay = "2nd"
				addpoints = 8
			3:
				placeDisplay = "3rd"
				addpoints = 5
			4,5,6,7,8,9:
				placeDisplay = str(place)+"th"
				addpoints = 2
		globals.points += addpoints
		$gui/TrackTitle.text = placeDisplay+" position"
		$gui/PointsAdded.text = "+"+str(addpoints)+" points"
		$gui/Prompt.show()
		$gui/TrackTitle.show()
		$gui/PointsAdded.show()
