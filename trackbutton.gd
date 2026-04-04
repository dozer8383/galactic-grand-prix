extends Button

signal trackSelected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("trackSelected", $"../../../.."._on_track_selected)
	connect("focus_entered", focused)

func _pressed() -> void:
	trackSelected.emit()

func focused() -> void:
	globals.currenttrackid = get_meta("trackID")
