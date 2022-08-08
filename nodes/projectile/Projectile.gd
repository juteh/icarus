extends Area2D

export var jumpPower: float = 400
export var shootPower: float = 400
export var impulsePower: float = 100
export var weight: float = 3
var isCollidingWithCatapult: bool = false
var velocity = Vector2(0, 0)
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
	if (GameStatus.isLanded && velocity.y > 0):
		velocity.y = 0

# projectile can make a little impulse to stay in the air longer
func impulse() -> void:
	if (impulseAttempts > 0):
		velocity.y -= impulsePower
		impulseAttempts -= 1

# get boost from item
func boost(boostPowerX: float = 0, boostPowerY: float = 0) -> void:
	velocity.x += boostPowerX
	velocity.y -= boostPowerY

# the initial jump of the projectile to the catapult
func jump() -> void:
	velocity.y -= jumpPower

# triggers when catapult fires the projectile
func shoot() -> void:
	var direction: Vector2 = (position - GameStatus.catapult.position).normalized()
	velocity += direction * shootPower
	velocity.x += 200

func _on_Catapult_body_entered(_body: Area2D) -> void:
	isCollidingWithCatapult = true

func _on_Catapult_body_exited(_body: Area2D) -> void:
	isCollidingWithCatapult = false
	
func _on_Ground_body_entered(_body: Area2D) -> void:
	if ("projectile" in _body.name.to_lower()):
		GameStatus.isLanded = true
	
func _on_Ground_body_exited(_body: Area2D) -> void:
	GameStatus.isLanded = false
	
