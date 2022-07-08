extends Area2D

var camera: Camera2D = null
var cameraStartPosition: Vector2 = Vector2.ZERO
var winTimer: Timer = null

func _ready() -> void:
	GameStatus.catapult = self
	camera = get_parent().get_node("Camera2D")
	cameraStartPosition = camera.position
	winTimer = get_node("WinTimer")

func _process(_delta):
	if (GameStatus.isShooted):
		camera.current = true
		camera.position.x = GameStatus.projectileInstance.position.x + 255
		camera.position.y = GameStatus.projectileInstance.position.y
	if (GameStatus.isLanded && winTimer.is_stopped()):
		winTimer.start()

func _physics_process(_delta) -> void:
	if (Input.is_action_just_pressed("ui_accept") && !GameStatus.projectileInstance):
		print("START")
		GameStatus.spawnProjectile()
	elif (Input.is_action_just_pressed("ui_accept") && !GameStatus.hasJumped):
		print("JUMP")
		GameStatus.projectileInstance.jump()
		GameStatus.hasJumped = true
	elif (Input.is_action_just_pressed("ui_accept") && !GameStatus.isShooted && GameStatus.projectileInstance.isCollidingWithCatapult):
		print("SHOOT")
		camera.current = true
		GameStatus.projectileInstance.shoot()
		GameStatus.isShooted = true

func _on_WinTimer_timeout():
	print("RESET")
	winTimer.stop()
	GameStatus.startNextRound()
	camera.position = cameraStartPosition
	
	
