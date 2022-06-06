extends Area2D

func _on_SpeedItem_area_entered(area: Area2D):
	print(area.name)
	if (area.name == "Projectile"):
		area.boost(200, 200)
