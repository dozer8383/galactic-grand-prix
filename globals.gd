extends Node

var currenttrackid = 0
var start_time = 0
var timerStarted = false
var bestTimes = [0,0,0,0,0,0,0,0,0,0]
var bestPoints = [0,0,0]
var botFinishes = 0
var raceType = 0
var points = 0
var raceStarted = false
var shipChoice = 0
var sfxVolume = 50
var sensitivity = 1.0
var currentprix = 0

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
		
func saveItem(json: Variant, savefile: FileAccess):
	var json_string = JSON.stringify(json)
	savefile.store_line(json_string)
	
func readItem(savefile: FileAccess) -> Variant:
	var json_string = savefile.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		printerr("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
	return json.data

func saveGame():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	saveItem(globals.bestTimes, save_file)
	saveItem(globals.bestPoints, save_file)
	save_file.store_line(str(globals.shipChoice))
	save_file.store_line(str(globals.sfxVolume))
	save_file.store_line(str(globals.sensitivity))

func loadGame():
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		printerr("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
	globals.bestTimes = json.data
	if len(globals.bestTimes) < 10:
		globals.bestTimes.resize(10)
	json_string = save_file.get_line()
	json = JSON.new()
	parse_result = json.parse(json_string)
	if not parse_result == OK:
		printerr("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
	globals.bestPoints = json.data
	if len(globals.bestTimes) < 3:
		globals.bestTimes.resize(3)
	globals.shipChoice = int(save_file.get_line())
	globals.sfxVolume = int(save_file.get_line())
	globals.sensitivity = float(save_file.get_line())
	if globals.sensitivity < 0.5: globals.sensitivity = 1
