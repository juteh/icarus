extends CanvasLayer


func _ready():
	pass


func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	var error_change_scene = get_tree().change_scene("res://nodes/World.tscn")
	if (error_change_scene != 0):
		print_debug("error_change_scene: ", error_change_scene)
