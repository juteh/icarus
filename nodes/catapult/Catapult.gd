extends Area2D

var Projectile = preload("res://nodes/projectile/Projectile.tscn")
var Projectile2 = preload("res://nodes/projectile/Projectile_2.tscn")
#var projectileInstance: KinematicBody2D = null
var projectileInstance: RigidBody2D = null
var SpawnPoint: Position2D = null
var camera: Camera2D = null
var distanceLabelX: Label = null
var distanceLabelY: Label = null
var angleLabel: Label = null

func _ready() -> void:
	SpawnPoint = get_parent().get_node("SpawnPoint")
	camera = get_parent().get_node("Camera2D")
	distanceLabelX = get_parent().get_node("CanvasLayer/DistanceLabelX")
	distanceLabelY = get_parent().get_node("CanvasLayer/DistanceLabelY")
	angleLabel = get_parent().get_node("CanvasLayer/AngleLabel")

func _process(_delta):
	if (projectileInstance):
		distanceLabelX.text = "Distance X: " + str(projectileInstance.position.x)
		distanceLabelY.text = "Distance Y: " + str(projectileInstance.position.y)
		angleLabel.text = "Angle: " + str(projectileInstance.rotation)
	if (GameStatus.isShooted):
		camera.current = true
		camera.position.x = projectileInstance.position.x + 255
		camera.position.y = projectileInstance.position.y

func _physics_process(delta) -> void:
	if (Input.is_action_just_pressed("ui_accept") && !GameStatus.projectileExist):
		print("SPAWN")
		spawnProjectile()
		GameStatus.projectileExist = true
	elif (Input.is_action_just_pressed("ui_accept") && !GameStatus.hasJumped):
		print("JUMP")
		projectileInstance.jump(delta)
		GameStatus.hasJumped = true
	elif (Input.is_action_just_pressed("ui_accept") && !GameStatus.isShooted && projectileInstance.isCollingWithCatapult()):
		print("SHOOT")
		camera.current = true
		projectileInstance.shoot(delta)
		GameStatus.isShooted = true

func spawnProjectile() -> void:
	projectileInstance = Projectile2.instance()
	projectileInstance.spawn(SpawnPoint.position, SpawnPoint.rotation, self)
	get_parent().add_child(projectileInstance)
