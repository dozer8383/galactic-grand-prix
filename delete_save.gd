extends Button

var sure = false

func _pressed() -> void:
	if sure:
		globals.bestTimes = [0,0,0,0,0,0,0,0,0,0]
		globals.bestPoints = [0,0,0]
		globals.shipChoice = 0
		globals.saveGame()
		text = "Deleted."
		globals.loadGame()
	else:
		text = "u sure bro?"
		sure = true
		
