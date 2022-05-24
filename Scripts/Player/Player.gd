extends "Entity.gd"

export var acceleration = 500
export var max_speed = 80
export var friction = 500


var state = MOVE
var velocity = Vector2.ZERO
var inventory_resource = load("res://Scripts/Player/Inventory.gd")
var inventory = inventory_resource.new()

onready var game_state = get_node("/root/GameState")
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	game_state.connect("no_health", self, "queue_free")


# Code so far based on HeartBeast tutorial
# https://youtu.be/TQKXU7iSWUU
func _physics_process(delta):
	match state:
		MOVE:
			enter_move(delta)
		ATTACK:
			attack_state(delta)


func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()


func enter_move(delta):
	var input_vector = get_input_vector()
	
	.move_state(delta, input_vector)

func attack_state(delta):
	pass
