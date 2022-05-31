extends Area2D

export var jumpPower: float = 400
export var shootPower: float = 100
export var impulsePower: float = 30
export var weight: float = 1
var isCollidingWithCatapult: bool = false
var velocity = Vector2(0, 0)
var isOnGround: bool = false
var impulseAttempts: int = 11

func _process(delta):
	# initial and while is landed the projectile has no movement
	if (!GameStatus.hasJumped && !GameStatus.isShooted || GameStatus.isLanded):
		return
	velocity.y += gravity * delta + weight
	position += velocity * delta
	if (GameStatus.isShooted):
		# only rotate when shooted
		rotation = velocity.angle()
		if (Input.is_action_just_pressed("ui_accept")):
			impulse()
	if (isOnGround && velocity.y > 0):
		velocity.y = 0

func impulse() -> void:
	if (impulseAttempts > 0):
		velocity.y -= impulsePower
		impulseAttempts -= 1

func jump() -> void:
	velocity.y -= jumpPower
	
func shoot() -> void:
	var direction: Vector2 = (position - GameStatus.catapult.position).normalized()
	velocity += direction * shootPower
	velocity.x += 200

func _on_Catapult_body_entered(_body: Area2D) -> void:
	print("_on_Catapult_body_entered")
	isCollidingWithCatapult = true

func _on_Catapult_body_exited(_body: Area2D) -> void:
	print("_on_Catapult_body_exited")
	isCollidingWithCatapult = false
	
func _on_Ground_body_entered(_body: Area2D) -> void:
	print("_on_Ground_body_entered")
	isOnGround = true
	
func _on_Ground_body_exited(_body: Area2D) -> void:
	print("_on_Ground_body_exited")
	isOnGround = false
	if (GameStatus.isShooted):
		GameStatus.isLanded = true
