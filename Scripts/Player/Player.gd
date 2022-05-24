extends KinematicBody2D

export var acceleration = 500
export var max_speed = 80
export var friction = 500

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var inventory_resource = load("res://Scripts/Player/Inventory.gd")
var inventory = inventory_resource.new()

onready var game_state = get_node("/root/GameState")

onready var animated_sprite = $AnimatedSprite

func _ready():
	game_state.connect("no_health", self, "queue_free")

# Code so far based on HeartBeast tutorial
# https://youtu.be/TQKXU7iSWUU
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)


func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()


func move_state(delta):
	var input_vector = get_input_vector()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animated_sprite.set_flip_h(false)
			animated_sprite.set_animation("run_right_down")
		if input_vector.x < 0:
			animated_sprite.set_flip_h(true)
			animated_sprite.set_animation("run_right_down")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		animated_sprite.set_animation("idle_right_down")
		
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	var input_vector = get_input_vector()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			animated_sprite.set_flip_h(false)
			animated_sprite.set_animation("attack")
		if input_vector.x < 0:
			animated_sprite.set_flip_h(true)
			animated_sprite.set_animation("attack")
	else:
		animated_sprite.set_animation("attack")
	
