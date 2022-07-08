extends Node2D

var Ground = preload("res://nodes/Ground/Ground.tscn")

onready var camera: Camera2D = get_parent().get_node("Camera2D")
onready var spawnPointGround: Position2D = $SpawnPointGround
onready var firstGround: Area2D = $Ground
# the distance between the new grounds
var spawnLength: float;
var listOfGrounds = []
var startPointGround: Vector2 

func _ready():
	GameStatus.ground = firstGround
	GameStatus.groundManager = self
	listOfGrounds.append(firstGround)
	spawnLength = spawnPointGround.global_position.x
	startPointGround = spawnPointGround.global_position

func _physics_process(_delta):
	if ((spawnPointGround.global_position.x - 10.0) < camera.global_position.x && camera.global_position.x < (spawnPointGround.global_position.x + 10.0)):
		print("SPAWN")
		var newGround: Area2D = Ground.instance()
		newGround.position = Vector2(spawnPointGround.global_position.x + spawnLength, spawnPointGround.position.y)
		newGround.connect("area_entered", GameStatus.projectileInstance, "_on_Ground_body_entered")
		newGround.connect("area_exited", GameStatus.projectileInstance, "_on_Ground_body_exited")
		spawnPointGround.global_position.x = spawnPointGround.global_position.x + spawnLength
		add_child(newGround)
		listOfGrounds.append(newGround)
		
func remove_grounds():
	spawnPointGround.global_position.x = startPointGround.x
	if (listOfGrounds.size() > 1):
		for i in range(1, listOfGrounds.size()):
			var element = listOfGrounds[i]
			element.queue_free()
		listOfGrounds = [firstGround]
