extends Area2D

func _on_SpeedItem_area_entered(area: Area2D):
	if (area.name == "Projectile"):
		area.boost(200, 200)
