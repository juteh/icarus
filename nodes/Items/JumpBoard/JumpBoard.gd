extends Area2D

func _on_Area2D_area_entered(area):
	if (area.name == "Projectile"):
		area.boost(0, 1000)

