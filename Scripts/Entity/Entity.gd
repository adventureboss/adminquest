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

onready var game_state = get_node("/root/GameState")
onready var animation_player = get_node_or_null("AnimationPlayer")
onready var animation_tree = get_node_or_null("AnimationTree")
onready var swordHitbox = $Hitbox
var animation_state = null

func _ready():
	game_state.connect("no_health", self, "queue_free")
	if animation_tree:
		 animation_state = animation_tree.get("parameters/playback")
	
func _physics_process(delta):
	pass

func move_state(delta, movement_vector):
	if movement_vector != Vector2.ZERO:
		if animation_tree:
			animation_tree.set("parameters/idle/blend_position", movement_vector)
			animation_tree.set("parameters/run/blend_position", movement_vector)
			animation_tree.set("parameters/attack/blend_position", movement_vector)
			animation_state.travel("run")
		velocity = velocity.move_toward(movement_vector * max_speed, acceleration * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		if animation_state:
			animation_state.travel("idle")
		
	velocity = move_and_slide(velocity)

func light_attack_state(delta):
	pass

func ranged_attack_state(delta):
	pass
