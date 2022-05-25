extends Node2D

const ENERGYBALL_SPEED = 200

func _ready() -> void:
	set_process(true)

func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = 1
	input_vector.y = 0
	return input_vector

func _process(delta: float) -> void:
	var motion = get_input_vector() * ENERGYBALL_SPEED
	
	# Movement equation
	set_position(get_position() + motion * delta)
	
	
