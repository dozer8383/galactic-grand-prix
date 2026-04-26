extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	globals.loadGame()
	get_node("VBoxContainer/SFXSlider").grab_focus()
	$VBoxContainer/SFXSlider.value = globals.sfxVolume
	$VBoxContainer/SensitivitySlider.value = globals.sensitivity


#func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	#globals.sfxVolume = $VBoxContainer/HSlider.value
	#globals.saveGame()


func _on_sensitivity_slider_value_changed(value: float) -> void:
	globals.sensitivity = $VBoxContainer/SensitivitySlider.value
	globals.saveGame()


func _on_sfx_slider_value_changed(value: float) -> void:
	globals.sfxVolume = $VBoxContainer/SFXSlider.value
	globals.saveGame()


func _on_quality_select_item_selected(index: int) -> void:
	RenderingServer.directional_shadow_atlas_set_size(2^(index+10),true)
