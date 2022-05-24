extends "Entity.gd"

var state = MOVE
var inventory_resource = load("res://Scripts/Player/Inventory.gd")
var inventory = inventory_resource.new()

func _ready():
	animation_player = $AnimationPlayer
	animation_tree = $AnimationTree
	animation_state = animation_tree.get("parameters/playback")
	game_state.connect("no_health", self, "queue_free")


# Code so far based on HeartBeast tutorial
# https://youtu.be/TQKXU7iSWUU
func _physics_process(delta):
	match state:
		MOVE:
			enter_move(delta)
		ATTACK:
			attack_state(delta)
			
	._physics_process(delta)


func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()


func enter_move(delta):
	var input_vector = get_input_vector()
	
	.move_state(delta, input_vector)

func attack_state(delta):
	animation_state.travel("attack")

func attack_animation_finished():
	state = MOVE
