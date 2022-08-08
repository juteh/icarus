extends CanvasLayer

onready var resultLabel1: Label = $Result1
onready var resultLabel2: Label = $Result2
onready var resultLabel3: Label = $Result3
onready var resultLabel4: Label = $Result4
onready var resultLabel5: Label = $Result5

func _ready():
	resultLabel1.text = "Round1: " + str(GameStatus.projectileResults[0]) + "m"
	resultLabel2.text = "Round2: " + str(GameStatus.projectileResults[1]) + "m"
	resultLabel3.text = "Round3: " + str(GameStatus.projectileResults[2]) + "m"
	resultLabel4.text = "Round4: " + str(GameStatus.projectileResults[3]) + "m"
	resultLabel5.text = "Round5: " + str(GameStatus.projectileResults[4]) + "m"

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_RestartButton_pressed():
	GameStatus.restart()
	var error_change_scene = get_tree().change_scene("res://nodes/World.tscn")
	if (error_change_scene != 0):
		print_debug("error_change_scene: ", error_change_scene)
