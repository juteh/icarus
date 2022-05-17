extends Area2D

var camera: Camera2D = null
var cameraStartPosition: Vector2 = Vector2.ZERO
var winTimer: Timer = null

func _ready() -> void:
	GameStatus.catapult = self
	camera = get_parent().get_node("Camera2D")
	cameraStartPosition = camera.position
	winTimer = $WinTimer

func _process(_delta):
	if (GameStatus.isShooted):
		camera.current = true
		camera.position.x = GameStatus.projectileInstance.position.x + 255
		camera.position.y = GameStatus.projectileInstance.position.y
	if (GameStatus.isLanded):
		GameStatus.projectileInstance.mode = RigidBody2D.MODE_STATIC
		GameStatus.projectileInstance.collision_layer = 0

func _physics_process(_delta) -> void:
	if (Input.is_action_just_pressed("ui_accept") && !GameStatus.projectileExist):
		print("SPAWN")
		GameStatus.spawnProjectile()
		GameStatus.projectileExist = true
	elif (Input.is_action_just_pressed("ui_accept") && !GameStatus.hasJumped):
		print("JUMP")
		GameStatus.projectileInstance.jump()
		GameStatus.hasJumped = true
	elif (Input.is_action_just_pressed("ui_accept") && !GameStatus.isShooted && GameStatus.projectileInstance.isCollingWithCatapult()):
		print("SHOOT")
		camera.current = true
		GameStatus.projectileInstance.shoot()
		GameStatus.isShooted = true

func _on_CheckCollideArea_body_entered(body):
	print(body.name)
	if (GameStatus.isShooted && body.name == "Projectile"):
		print("LANDED")
		GameStatus.isLanded = true;
		winTimer.start()

func _on_WinTimer_timeout():
	winTimer.stop()
	print("RESET")
	GameStatus.landedProjectiles.append(stepify(GameStatus.projectileInstance.position.x / 100, 0.01))
	GameStatus.projectileInstance.destroy()
	GameStatus.projectileInstance = null
	GameStatus.reset()
	camera.position = cameraStartPosition
