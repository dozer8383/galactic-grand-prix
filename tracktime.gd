extends Button

func _ready() -> void:
	var trackid = get_meta("trackID")
	var temptime: float = globals.bestTimes[trackid]
	text = "%01d:%02d.%03d" % [temptime/60000,int(temptime/1000.0)%60,int(temptime)%1000]
