extends KinematicBody2D

var gravity: float = 1000
var velocity: Vector2 = Vector2()
var speed: float = 750
var jumpPower: float = 50000
var shootPowerX: float = 150000
var shootPowerY: float = 50000
var catapult: Area2D = null
var _isCollingWithCatapult: bool = false
var friction = 0.05

func _physics_process(delta):
	velocity.y += gravity * delta
	if (is_on_floor() && GameStatus.isShooted):
		velocity.x *= lerp(1, 0, friction)
		
	velocity = move_and_slide(velocity, Vector2.UP)

func spawn(pos: Vector2, dir: float, _catapult: Area2D):
	rotation = dir
	position = pos
	catapult = _catapult
	catapult.connect("body_entered", self, "_on_Catapult_body_entered")
	catapult.connect("body_exited", self, "_on_Catapult_body_exited")

func jump(delta) -> void:
	velocity.y -= jumpPower * delta
	
func shoot(delta) -> void:
	var direction: Vector2 = (position - catapult.position).normalized()
	print(direction)
	velocity = direction
	velocity.x += shootPowerX * delta
	velocity.y *= shootPowerY * delta

func _on_Catapult_body_entered(body: Node2D) -> void:
	var direction: Vector2 = (position - catapult.position).normalized()
	_isCollingWithCatapult = true

func _on_Catapult_body_exited(body: Node2D) -> void:
	var direction: Vector2 = (position - catapult.position).normalized()
	_isCollingWithCatapult = false
	
func isCollingWithCatapult() -> bool:
	return _isCollingWithCatapult
