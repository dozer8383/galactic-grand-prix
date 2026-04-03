extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("VBoxContainer/RayMachine").grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ray_machine_pressed() -> void:
	globals.shipChoice = 0
	globals.saveGame()
	get_tree().change_scene_to_file("res://mainmenu.tscn")


func _on_vector_machine_pressed() -> void:
	globals.shipChoice = 1
	globals.saveGame()
	get_tree().change_scene_to_file("res://mainmenu.tscn")


func _on_tracer_machine_pressed() -> void:
	globals.shipChoice = 2
	globals.saveGame()
	get_tree().change_scene_to_file("res://mainmenu.tscn")


func _on_ray_machine_focus_entered() -> void:
	$"../pedestal/ray".show()
	$"../pedestal/vector".hide()
	$"../pedestal/tracer".hide()


func _on_vector_machine_focus_entered() -> void:
	$"../pedestal/ray".hide()
	$"../pedestal/vector".show()
	$"../pedestal/tracer".hide()


func _on_tracer_machine_focus_entered() -> void:
	$"../pedestal/ray".hide()
	$"../pedestal/vector".hide()
	$"../pedestal/tracer".show()
