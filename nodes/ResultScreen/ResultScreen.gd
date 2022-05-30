extends CanvasLayer

onready var resultLabel1: Label = $Result1
onready var resultLabel2: Label = $Result2
onready var resultLabel3: Label = $Result3
onready var resultLabel4: Label = $Result4
onready var resultLabel5: Label = $Result5

func _ready():
	resultLabel1.text = "Result: " + str(GameStatus.projectileResults[0]) + "m"
	resultLabel2.text = "Result: " + str(GameStatus.projectileResults[1]) + "m"
	resultLabel3.text = "Result: " + str(GameStatus.projectileResults[2]) + "m"
	resultLabel4.text = "Result: " + str(GameStatus.projectileResults[3]) + "m"
	resultLabel5.text = "Result: " + str(GameStatus.projectileResults[4]) + "m"

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_RestartButton_pressed():
	GameStatus.restart()
	get_tree().change_scene("res://nodes/World.tscn")
