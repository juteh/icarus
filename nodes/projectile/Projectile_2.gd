extends RigidBody2D

var catapult: Area2D = null
var _isCollingWithCatapult: bool = false
var jumpPower: float = 750
var shootPower: float = 70

func _process(delta):
	pass
	
func _integrate_forces(state):
	# limitate rotation of the right side
	rotation = clamp(rotation, deg2rad(0), deg2rad(180))

func spawn(pos: Vector2, dir: float, _catapult: Area2D):
	rotation = dir
	position = pos
	catapult = _catapult
	catapult.connect("body_entered", self, "_on_Catapult_body_entered")
	catapult.connect("body_exited", self, "_on_Catapult_body_exited")

func jump(delta) -> void:
	apply_impulse(Vector2.ZERO, Vector2.UP * jumpPower)
	
func shoot(delta) -> void:
	var direction: Vector2 = (position - catapult.position).normalized()
	apply_impulse(Vector2.ZERO, direction.normalized() * jumpPower)

func _on_Catapult_body_entered(body: Node2D) -> void:
	var direction: Vector2 = (position - catapult.position).normalized()
	_isCollingWithCatapult = true

func _on_Catapult_body_exited(body: Node2D) -> void:
	var direction: Vector2 = (position - catapult.position).normalized()
	_isCollingWithCatapult = false
	
func isCollingWithCatapult() -> bool:
	return _isCollingWithCatapult

func destroy() -> void:
	queue_free()
