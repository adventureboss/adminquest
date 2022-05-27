extends KinematicBody2D

export(int) var acceleration = 500
export(int) var max_speed = 80
export(int) var friction = 500

var velocity = Vector2.ZERO

enum {
	MOVE,
	LIGHT_ATTACK,
	RANGED_ATTACK
}

# Knockback properties
var knockback_vector = Vector2.ZERO
export var knockback_force = 100
export var knockback_dur = .15
var current_knockback_dur = 0

onready var HitEffect = preload("res://newEffects/HitEffect.tscn")
onready var game_state = get_node("/root/GameState")
onready var animation_player = get_node_or_null("AnimationPlayer")
onready var animation_tree = get_node_or_null("AnimationTree")
var animation_state = null

var facingDirection: Vector2 = Vector2.RIGHT

func _ready():
	if animation_tree:
		 animation_state = animation_tree.get("parameters/playback")

func knockback(area):
	var effect = HitEffect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position
	knockback_vector = (global_position - area.global_position).normalized() * knockback_force
	current_knockback_dur = knockback_dur
	
func _physics_process(delta):
	if current_knockback_dur >= 0.0:
		var _collision = move_and_slide(knockback_vector)
		current_knockback_dur -= delta

	else:
		knockback_vector = Vector2.ZERO

func move_state(delta, movement_vector):
	if movement_vector != Vector2.ZERO:
		var normalizedMovementVector = movement_vector.normalized()
		if normalizedMovementVector.x > 0:
			facingDirection = Vector2.RIGHT
		elif normalizedMovementVector.x < 0:
			facingDirection = Vector2.LEFT

		if animation_tree:
			animation_tree.set("parameters/idle/blend_position", facingDirection)
			animation_tree.set("parameters/run/blend_position", facingDirection)
			animation_tree.set("parameters/light_attack/blend_position", facingDirection)
			animation_state.travel("run")
		velocity = velocity.move_toward(movement_vector * max_speed, acceleration * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		if animation_state:
			animation_state.travel("idle")
		
	velocity = move_and_slide(velocity)

func light_attack_state(_delta):
	pass

func ranged_attack_state(_delta):
	pass
