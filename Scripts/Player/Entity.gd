extends KinematicBody2D

export var acceleration = 500
export var max_speed = 80
export var friction = 500

var velocity = Vector2.ZERO

enum {
	MOVE,
	ATTACK
}

onready var game_state = get_node("/root/GameState")
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	game_state.connect("no_health", self, "queue_free")

func _physics_process(delta):
	pass

func move_state(delta, movement_vector):
	if movement_vector != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", movement_vector)
		animation_tree.set("parameters/run/blend_position", movement_vector)
		animation_state.travel("run")
		velocity = velocity.move_toward(movement_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		animation_state.travel("idle")
		
	velocity = move_and_slide(velocity)

func attack_state(delta):
	pass
