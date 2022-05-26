extends Node2D

const MISSILE_SPEED = 200

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += MISSILE_SPEED * direction * delta


func destroy():
	queue_free()

func _on_Hitbox_area_entered(area):
	destroy()

func _on_Hitbox_body_entered(area):
	destroy()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
