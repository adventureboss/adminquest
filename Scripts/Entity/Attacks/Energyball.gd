extends Node2D

const MISSILE_SPEED = 200
var direction = Vector2.RIGHT

onready var sprite = $AnimatedSprite

func _physics_process(delta: float) -> void:
	if direction == Vector2.LEFT:
		sprite.flip_h = true
	global_position += MISSILE_SPEED * direction * delta


func destroy():
	queue_free()

func _on_Hitbox_area_entered(_area):
	destroy()

func _on_Hitbox_body_entered(_area):
	destroy()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
