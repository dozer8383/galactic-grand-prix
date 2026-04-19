extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.loadGame()
	get_node("VBoxContainer/HSlider").grab_focus()
	$VBoxContainer/HSlider.value = globals.sfxVolume


#func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	#globals.sfxVolume = $VBoxContainer/HSlider.value
	#globals.saveGame()


func _on_h_slider_value_changed(value: float) -> void:
	globals.sfxVolume = $VBoxContainer/HSlider.value
	globals.saveGame()
