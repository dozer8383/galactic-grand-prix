extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match globals.currenttrackid:
		0:
			$"../track1/FinishCheckpoint".finishcrossed.connect()
		1:
			$"../../track2/track/FinishCheckpoint".finishcrossed.connect()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Time.text = str(globals.timerGet())
