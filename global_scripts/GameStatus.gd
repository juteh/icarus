extends Node

var Projectile = preload("res://nodes/projectile/Projectile.tscn")

const ATTEMPTS = 5

var projectileExist = false
var hasJumped = false
var isShooted = false
var isLanded = false

var landedProjectiles = []

var catapult: Area2D = null
var ground: Area2D = null
var projectileInstance: Area2D = null
var spawnPoint: Position2D = null

func spawnProjectile():
	projectileInstance = Projectile.instance()
	projectileInstance.position = spawnPoint.position
	var error_code_1 = GameStatus.catapult.connect("area_entered", projectileInstance, "_on_Catapult_body_entered")
	var error_code_2 = GameStatus.catapult.connect("area_exited", projectileInstance, "_on_Catapult_body_exited")
	var error_code_3 = GameStatus.ground.connect("area_entered", projectileInstance, "_on_Ground_body_entered")
	var error_code_4 = GameStatus.ground.connect("area_exited", projectileInstance, "_on_Ground_body_exited")
	if (error_code_1 != 0):
		print("ERROR_1: ", error_code_1)
	if (error_code_2 != 0):
		print("ERROR_2: ", error_code_2)
	if (error_code_3 != 0):
		print("ERROR_3: ", error_code_3)
	if (error_code_4 != 0):
		print("ERROR_4: ", error_code_4)
	get_parent().add_child(projectileInstance)

func reset():
	projectileExist = false
	hasJumped = false
	isShooted = false
	isLanded = false
