extends RigidBody2D

var catapult: Area2D = null
var _isCollingWithCatapult: bool = false
var jumpPower: float = 750
var shootPower: float = 70
	
func _integrate_forces(_state):
	# limitate rotation of the right side
	rotation = clamp(rotation, deg2rad(0), deg2rad(180))

func spawn(pos: Vector2, dir: float, _catapult: Area2D):
	rotation = dir
	position = pos
	catapult = _catapult
	var error_code_1 = catapult.connect("body_entered", self, "_on_Catapult_body_entered")
	var error_code_2 = catapult.connect("body_exited", self, "_on_Catapult_body_exited")
	if (error_code_1 != 0):
		print("ERROR: ", error_code_1)
	if (error_code_2 != 0):
		print("ERROR: ", error_code_2)

func jump() -> void:
	apply_impulse(Vector2.ZERO, Vector2.UP * jumpPower)
	
func shoot() -> void:
	var direction: Vector2 = (position - catapult.position).normalized()
	apply_impulse(Vector2.ZERO, direction.normalized() * jumpPower)

func _on_Catapult_body_entered(_body: Node2D) -> void:
	var _direction: Vector2 = (position - catapult.position).normalized()
	_isCollingWithCatapult = true

func _on_Catapult_body_exited(_body: Node2D) -> void:
	var _direction: Vector2 = (position - catapult.position).normalized()
	_isCollingWithCatapult = false
	
func isCollingWithCatapult() -> bool:
	return _isCollingWithCatapult

func destroy() -> void:
	queue_free()
