extends Area2D

var Projectile = preload("res://nodes/projectile/Projectile.tscn")
var projectileInstance: RigidBody2D = null
var SpawnPoint: Position2D = null
var camera: Camera2D = null
var cameraStartPosition: Vector2 = Vector2.ZERO
var distanceLabelX: Label = null
var distanceLabelY: Label = null
var angleLabel: Label = null
var scoreLabel: Label = null
var roundLabel: Label = null
var winTimer: Timer = null

func _ready() -> void:
	SpawnPoint = get_parent().get_node("SpawnPoint")
	camera = get_parent().get_node("Camera2D")
	cameraStartPosition = camera.position
	distanceLabelX = get_parent().get_node("CanvasLayer/DistanceLabelX")
	distanceLabelY = get_parent().get_node("CanvasLayer/DistanceLabelY")
	angleLabel = get_parent().get_node("CanvasLayer/AngleLabel")
	scoreLabel = get_parent().get_node("CanvasLayer/ScoreLabel")
	roundLabel = get_parent().get_node("CanvasLayer/RoundLabel")
	winTimer = get_node("WinTimer")
	scoreLabel.visible = false;

func _process(_delta):
	roundLabel.text = "Round " + str(GameStatus.landedProjectiles.size() + 1)
	if (projectileInstance):
		distanceLabelX.text = "Distance X: " + str(projectileInstance.position.x)
		distanceLabelY.text = "Distance Y: " + str(projectileInstance.position.y)
		angleLabel.text = "Angle: " + str(projectileInstance.rotation)
	if (GameStatus.isShooted):
		camera.current = true
		camera.position.x = projectileInstance.position.x + 255
		camera.position.y = projectileInstance.position.y
	if (GameStatus.isLanded):
		projectileInstance.mode = RigidBody2D.MODE_STATIC
		projectileInstance.collision_layer = 0
		scoreLabel.text = "Es ist " + str(stepify(projectileInstance.position.x / 100, 0.01)) + "m geflogen!"
		scoreLabel.visible = true;

func _physics_process(_delta) -> void:
	if (Input.is_action_just_pressed("ui_accept") && !GameStatus.projectileExist):
		print("SPAWN")
		spawnProjectile()
		GameStatus.projectileExist = true
	elif (Input.is_action_just_pressed("ui_accept") && !GameStatus.hasJumped):
		print("JUMP")
		projectileInstance.jump()
		GameStatus.hasJumped = true
	elif (Input.is_action_just_pressed("ui_accept") && !GameStatus.isShooted && projectileInstance.isCollingWithCatapult()):
		print("SHOOT")
		camera.current = true
		projectileInstance.shoot()
		GameStatus.isShooted = true

func spawnProjectile() -> void:
	projectileInstance = Projectile.instance()
	projectileInstance.spawn(SpawnPoint.position, SpawnPoint.rotation, self)
	get_parent().add_child(projectileInstance)


func _on_CheckCollideArea_body_entered(body):
	print(body.name)
	if (GameStatus.isShooted && body.name == "Projectile_2"):
		print("LANDED")
		GameStatus.isLanded = true;
		winTimer.start()

func _on_WinTimer_timeout():
	winTimer.stop()
	print("RESET")
	GameStatus.landedProjectiles.append(stepify(projectileInstance.position.x / 100, 0.01))
	projectileInstance.destroy()
	projectileInstance = null
	GameStatus.reset()
	camera.position = cameraStartPosition
	scoreLabel.visible = false;
