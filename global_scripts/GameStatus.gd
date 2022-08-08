extends Node

var Projectile = preload("res://nodes/projectile/Projectile.tscn")

const MAX_ATTEMPTS = 5

var hasJumped = false
var isShooted = false
var isLanded = false

var projectileResults = []

var catapult: Area2D = null
var ground: Area2D = null
var projectileInstance: Area2D = null
var spawnPointProjectile: Position2D = null
var groundManager = null
var itemManager = null

func spawnProjectile():
	projectileInstance = Projectile.instance()
	projectileInstance.position = spawnPointProjectile.position
	var error_code_1 = catapult.connect("area_entered", projectileInstance, "_on_Catapult_body_entered")
	var error_code_2 = catapult.connect("area_exited", projectileInstance, "_on_Catapult_body_exited")
	var error_code_3 = ground.connect("area_entered", projectileInstance, "_on_Ground_body_entered")
	var error_code_4 = ground.connect("area_exited", projectileInstance, "_on_Ground_body_exited")
	if (error_code_1 != 0):
		print_debug("ERROR: _on_Catapult_body_entered: ", error_code_1)
	if (error_code_2 != 0):
		print_debug("ERROR: _on_Catapult_body_exited: ", error_code_2)
	if (error_code_3 != 0):
		print_debug("ERROR: _on_Ground_body_entered: ", error_code_3)
	if (error_code_4 != 0):
		print_debug("ERROR: _on_Ground_body_exited: ", error_code_4)
	get_parent().add_child(projectileInstance)

func startNextRound():
	projectileResults.append(stepify(projectileInstance.position.x / 100, 0.01))
	projectileInstance.queue_free()
	projectileInstance = null
	hasJumped = false
	isShooted = false
	isLanded = false
	groundManager.remove_grounds()
	itemManager.remove_items()
	if (GameStatus.projectileResults.size() == GameStatus.MAX_ATTEMPTS):
		var error_change_scene = get_tree().change_scene("res://nodes/ResultScreen/ResultScreen.tscn")
		if (error_change_scene != 0):
			print_debug("error_change_scene: ", error_change_scene)
		
func restart():
	projectileResults = []
