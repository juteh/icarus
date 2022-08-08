extends Area2D

func _on_RechargeFlapsItem_area_entered(area):
	if (area.name == "Projectile"):
		if (GameStatus.projectileInstance.impulseAttempts > 7):
			GameStatus.projectileInstance.impulseAttempts = 10
		else:
			GameStatus.projectileInstance.impulseAttempts += 3
