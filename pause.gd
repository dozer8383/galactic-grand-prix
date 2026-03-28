extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func pause() -> void:
	get_tree().paused = true
	show()
	get_node("VBoxContainer/ContinueButton").grab_focus()


func _on_continue_button_pressed() -> void:
	print("i be clicked")
	hide()
	get_tree().paused = false


func _on_exit_button_pressed() -> void:
	print("i be clicked")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://mainmenu.tscn")
