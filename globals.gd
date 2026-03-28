extends Node

var currenttrackid = 0
var start_time = 0
var timerStarted = false
var bestTimes = [0,0,0,0,0]
var raceType = 0
var raceStarted = false

const timeTrial = 0
const grandPrix = 1
const challenge = 2

func _ready() -> void:
	loadGame()
func timerStart():
	start_time = Time.get_ticks_msec()
	timerStarted = true

func timerGet():
	if timerStarted:
		return Time.get_ticks_msec() - start_time
	else:
		return 0

func saveGame():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)

	# JSON provides a static method to serialized JSON string.
	var json_string = JSON.stringify(globals.bestTimes)

	# Store the save dictionary as a new line in the save file.
	save_file.store_line(json_string)

func loadGame():
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json_string = save_file.get_line()
	
	var json = JSON.new()
	
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	
	globals.bestTimes = json.data
	if len(globals.bestTimes) < 5:
		globals.bestTimes.resize(5)
