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
	$Stats/Speed/TextureProgressBar.value = 449
	$Stats/Acceleration/TextureProgressBar.value = 10-5
	$Stats/Handling/TextureProgressBar.value = 3
	$Stats/Weight/TextureProgressBar.value = 6

func _on_vector_machine_focus_entered() -> void:
	$"../pedestal/ray".hide()
	$"../pedestal/vector".show()
	$"../pedestal/tracer".hide()
	$Stats/Speed/TextureProgressBar.value = 393
	$Stats/Acceleration/TextureProgressBar.value = 10-2.5
	$Stats/Handling/TextureProgressBar.value = 4.5
	$Stats/Weight/TextureProgressBar.value = 3

func _on_tracer_machine_focus_entered() -> void:
	$"../pedestal/ray".hide()
	$"../pedestal/vector".hide()
	$"../pedestal/tracer".show()
	$Stats/Speed/TextureProgressBar.value = 515
	$Stats/Acceleration/TextureProgressBar.value = 10-8
	$Stats/Handling/TextureProgressBar.value = 2
	$Stats/Weight/TextureProgressBar.value = 9
