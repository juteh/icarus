extends Node

var JumpBoard = preload("res://nodes/Items/JumpBoard/JumpBoard.tscn")
var SpeedItem = preload("res://nodes/Items/SpeedItem/SpeedItem.tscn")
var RechargeFlapsItem = preload("res://nodes/Items/RechargeFlaps/RechargeFlapsItem.tscn")

onready var spawnPointJumpBoard: Position2D = $SpawnPointJumpBoard
onready var spawnJumpBoardTimer: Timer = $SpawnJumpBoardTimer
onready var spawnSpeedItemTimer: Timer = $SpawnSpeedItemTimer
onready var spawnPowerUpTimer: Timer = $SpawnPowerUpTimer

var rng = RandomNumberGenerator.new()
var rngItemPositionY = RandomNumberGenerator.new()
var rngItemPositionX = RandomNumberGenerator.new()

func _ready():
	GameStatus.itemManager = self

func _physics_process(_delta):
	if (GameStatus.isShooted && spawnJumpBoardTimer.is_stopped()):
		spawnJumpBoardTimer.start()
		spawnSpeedItemTimer.start()
		spawnPowerUpTimer.start()

func _on_SpawnJumpBoardTimer_timeout():
	rng.randomize()
	rngItemPositionX.randomize()
	var randomNumber = rng.randi_range(0, 10)
	var itemPositionX = rngItemPositionX.randf_range(900, 1200)
	if (randomNumber < 5 && GameStatus.projectileInstance != null):
		var jumpBoardInstance = JumpBoard.instance()
		jumpBoardInstance.position = Vector2(GameStatus.projectileInstance.position.x + itemPositionX, spawnPointJumpBoard.position.y)
		add_child(jumpBoardInstance)
	spawnJumpBoardTimer.stop()

func _on_SpawnSpeedItemTimer_timeout():
	rng.randomize()
	rngItemPositionX.randomize()
	rngItemPositionY.randomize()
	var randomNumber = rng.randi_range(0, 10)
	var itemPositionX = rngItemPositionX.randf_range(900, 1200)
	var speedItemPositionY = rngItemPositionY.randf_range(-500, 500)
	# don't spawn under the ground (< 300)
	if (randomNumber < 7 && GameStatus.projectileInstance != null && GameStatus.projectileInstance.position.y + speedItemPositionY < 300):
		var speedItemInstance = SpeedItem.instance()
		speedItemInstance.position = Vector2(GameStatus.projectileInstance.position.x + itemPositionX, GameStatus.projectileInstance.position.y + speedItemPositionY)
		add_child(speedItemInstance)
	spawnSpeedItemTimer.stop()

func _on_SpawnPowerUpTimer_timeout():
	rng.randomize()
	var randomNumber = rng.randi_range(0, 10)
	var itemPositionX = rngItemPositionX.randf_range(900, 1200)
	var rechargeFlapsItemPositionY = rngItemPositionY.randf_range(-500, 500)
	# don't spawn under the ground (< 300)
	if (randomNumber < 8 && GameStatus.projectileInstance != null && GameStatus.projectileInstance.position.y + rechargeFlapsItemPositionY < 300):
		var rechargeFlapsItem = RechargeFlapsItem.instance()
		rechargeFlapsItem.position = Vector2(GameStatus.projectileInstance.position.x + itemPositionX, GameStatus.projectileInstance.position.y + rechargeFlapsItemPositionY)
		add_child(rechargeFlapsItem)
	spawnPowerUpTimer.stop()
	
func remove_items():
	for node in get_tree().get_nodes_in_group("item"):
		node.queue_free()
