extends Node2D

var Ground = preload("res://nodes/Ground/Ground.tscn")

onready var camera: Camera2D = get_parent().get_node("Camera2D")
onready var spawnPointGround: Position2D = $SpawnPointGround
onready var firstGround: Area2D = $Ground
# the distance between the new grounds
var spawnLength: float;
var startPointGround: Vector2 

func _ready():
	GameStatus.ground = firstGround
	GameStatus.groundManager = self
	spawnLength = spawnPointGround.global_position.x
	startPointGround = spawnPointGround.global_position

func _physics_process(_delta):
	if ((spawnPointGround.global_position.x - 10.0) < camera.global_position.x && camera.global_position.x < (spawnPointGround.global_position.x + 10.0)):
		if (_check_ground_on_pos(Vector2(spawnPointGround.global_position.x + spawnLength, spawnPointGround.global_position.y))):
			var newGround: Area2D = Ground.instance()
			newGround.position = Vector2(spawnPointGround.global_position.x + spawnLength, spawnPointGround.position.y)
			var error_code_1 = newGround.connect("area_entered", GameStatus.projectileInstance, "_on_Ground_body_entered")
			if (error_code_1 != 0):
				print_debug("ERROR: _on_Ground_body_entered: ", error_code_1)
			var error_code_2 = newGround.connect("area_exited", GameStatus.projectileInstance, "_on_Ground_body_exited")
			if (error_code_2 != 0):
				print_debug("ERROR: _on_Ground_body_entered: ", error_code_2)
			spawnPointGround.global_position.x = spawnPointGround.global_position.x + spawnLength
			add_child(newGround)
		else:
			spawnPointGround.global_position.x = spawnPointGround.global_position.x + spawnLength
		
func remove_grounds():
	spawnPointGround.global_position.x = startPointGround.x
	for ground in get_tree().get_nodes_in_group("ground").slice(1,-1):
		ground.queue_free()
		
# check if ground already spawned on position
func _check_ground_on_pos(pos: Vector2) -> bool:
	for node in get_tree().get_nodes_in_group("ground"):
		if (pos.x == node.global_position.x && pos.y == node.global_position.y):
			return false
	return true
