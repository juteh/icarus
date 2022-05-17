extends Area2D

var isCollingWithCatapult: bool = false
var jumpPower: float = 400
var shootPower: float = 100
var velocity = Vector2(0, 0)
var isOnGround: bool = false;

func _process(delta):
	velocity.y += gravity * delta
	position += velocity * delta
	if (GameStatus.isShooted):
		rotation = velocity.angle()
	if (isOnGround && velocity.y > 0):
		velocity.y = 0

func jump() -> void:
	velocity.y -= jumpPower
	
func shoot() -> void:
	var direction: Vector2 = (position - GameStatus.catapult.position).normalized()
	velocity += direction * shootPower

func _on_Catapult_body_entered(_body: Area2D) -> void:
	print("_on_Catapult_body_entered")
	isCollingWithCatapult = true

func _on_Catapult_body_exited(_body: Area2D) -> void:
	print("_on_Catapult_body_exited")
	isCollingWithCatapult = false
	
func _on_Ground_body_entered(_body: Area2D) -> void:
	print("_on_Ground_body_entered")
	isOnGround = true
	
func _on_Ground_body_exited(_body: Area2D) -> void:
	print("_on_Ground_body_exited")
	isOnGround = false
	
func isCollingWithCatapult() -> bool:
	return isCollingWithCatapult

func destroy() -> void:
	queue_free()
