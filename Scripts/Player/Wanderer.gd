extends "Entity.gd"

var state = MOVE
var inventory_resource = load("res://Scripts/Player/Inventory.gd")
var inventory = inventory_resource.new()

enum movement {
	LEFT,
	RIGHT,
	UP,
	DOWN,
	STILL
}

export var movement_mag = .5
export var movement_dur = 1

var current_dir = movement.STILL
onready var current_dur = 0.0

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
	# make an input vector
	var movement_vector = Vector2.ZERO
	
	if current_dur <= 0.0:
		# returns an int 0 to 6
		var rand = randi()%8
		
		current_dir = rand
		current_dur = movement_dur
		
	match current_dir:
		movement.LEFT:
			movement_vector = Vector2(movement_mag * -1, 0.0)
		movement.RIGHT:
			movement_vector = Vector2(movement_mag * -1, 0.0)
		movement.UP:
			movement_vector = Vector2(0.0, movement_mag)
		movement.DOWN:
			movement_vector = Vector2(0.0, -1 * movement_mag)
		_:
			pass
			
	current_dur -= delta
		
	.move_state(delta, movement_vector)

func attack_state(delta):
	pass
