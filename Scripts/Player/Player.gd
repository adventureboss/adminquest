extends KinematicBody2D

export var acceleration = 500
export var max_speed = 80
export var friction = 500

var velocity = Vector2.ZERO

var stats = PlayerStats

#func _ready():
#	stats.connect("no_health", self, "queue_free")
onready var animated_sprite = $AnimatedSprite

# Code so far based on HeartBeast tutorial
# https://youtu.be/TQKXU7iSWUU
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		if input_vector.x > 0:
			animated_sprite.set_flip_h(false)
			animated_sprite.set_animation("run_right_down")
		if input_vector.x < 0:
			animated_sprite.set_flip_h(true)
			animated_sprite.set_animation("run_right_down")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animated_sprite.set_animation("idle_right_down")
		
	velocity = move_and_slide(velocity)
