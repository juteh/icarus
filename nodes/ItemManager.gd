extends Node

var JumpBoard = preload("res://nodes/Items/JumpBoard/JumpBoard.gd")
var SpeedItem = preload("res://nodes/Items/SpeedItem/SpeedItem.gd")

onready var spawnPointJumpBoard: Position2D = $SpawnPointJumpBoard
# TODO: Bei jedem neuen Ground, soll zufällig entschieden werden, ob ein Item spawn soll.
# Wenn ja hängt es vom Item wo es positioniert wird. 
# Ist es ein JumpBoard wird es am Boden zufällig auf Ground positioniert
# Bei einem Speeditem sollte es in einer ähnlichen Höhe wie das Projektil platziert werden
# oder vielleicht gar nicht auf ground achten und einfach nach einen gewissen abstand spawnen?
func _ready():
	pass

func _physics_process(_delta):
	# TODO benutze randombei bei allen 50m und entscheide, ob jumpBoard gespawnt werden soll
	pass
