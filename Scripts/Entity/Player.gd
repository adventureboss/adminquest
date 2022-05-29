extends "Entity.gd"

var state = MOVE

var inventory_resource = load("res://Scripts/Entity/Inventory.gd")
var inventory = inventory_resource.new()

const ENERGYBALL = preload("res://Scenes/Player/Attacks/Energyball.tscn")

var invincibile = false

onready var hurtbox = $Hurtbox

func _ready():
	var _useless = game_state.connect("no_health", self, "queue_free")
	
	animation_player = $AnimationPlayer
	animation_tree = $AnimationTree
	animation_state = animation_tree.get("parameters/playback")


# Code so far based on HeartBeast tutorial
# https://youtu.be/TQKXU7iSWUU
func _physics_process(delta):
	match state:
		MOVE:
			enter_move(delta)
		LIGHT_ATTACK:
			light_attack_state(delta)
		RANGED_ATTACK:
			ranged_attack_state(delta)

	if Input.is_action_just_pressed("light_attack"):
		state = LIGHT_ATTACK
		$AudioStreamPlayer.play()
	if Input.is_action_just_pressed("ranged_attack"):
		state = RANGED_ATTACK

	._physics_process(delta)


func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()


func enter_move(delta):
	var input_vector = get_input_vector()
	
	.move_state(delta, input_vector)

func light_attack_state(_delta):
	animation_state.travel("light_attack")

func ranged_attack_state(_delta):
	var energyball = ENERGYBALL.instance()

	get_tree().current_scene.add_child(energyball)
	energyball.global_position = self.global_position
	
	if facingDirection.x < 0:
		energyball.direction = Vector2.LEFT

	attack_animation_finished()

func attack_animation_finished():
	state = MOVE
	
func onPlayerHit(area):
	knockback(area)
	GameState.set_health(GameState.player_stats.health - 0.5)
	hurtbox.start_invincibility(0.5)
