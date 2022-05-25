extends "Player/Entity.gd"

enum State {
	IDLE,
	CHASE,
	CHASE_ENDING,
	WANDERING
}

enum Movement {
	LEFT,
	RIGHT,
	UP,
	DOWN,
	STILL
}

onready var body = $"AnimatedSprite/Moving Collision"
onready var playerDetection = $PlayerDetectionZone

# Following properties
export(bool) var shouldFollow = true
export(float) var timeFollowingAfterLost = 2.0
export(bool) var shouldFollowAfterLost = true

# Wandering properties
export(bool) var shouldWander = true
export(float) var timeWandering = 1
export(float) var wanderMovement = 0.5
export(float) var delayBeforeNextWander = 1.0

var state = State.IDLE
var timeSpentState = 0

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	queue_free()

func canSeePlayer():
	return playerDetection and playerDetection.canSeePlayer()

func moveToState(newState):
	if state != newState:
		state = newState
		timeSpentState = 0
		
func decideState(delta):
	timeSpentState += delta
	
	if shouldFollow and canSeePlayer():
		moveToState(State.CHASE)
	else:
		if state == State.CHASE:
			if shouldFollowAfterLost:
				moveToState(State.CHASE_ENDING)
			else:
				moveToState(State.IDLE)
		elif state == State.CHASE_ENDING and timeSpentState > timeFollowingAfterLost:
			moveToState(State.IDLE)
		elif state == State.IDLE and shouldMoveToWandering(delta):
			moveToState(State.WANDERING)
		elif state == State.WANDERING and timeSpentState > timeWandering:
			moveToState(State.IDLE)
			
func processIdleState(delta):
	.move_state(delta, Vector2.ZERO) 
	
# Assume playerDetection is available on the chase state
func processChaseState(delta):
	var direction: Vector2 = playerDetection.player.global_position - global_position
	if direction.length_squared() > 1:
		.move_state(delta, direction.normalized())
	else:
		velocity = Vector2.ZERO

func shouldMoveToWandering(delta):
	if shouldWander and timeSpentState > delayBeforeNextWander:
		var current_dir = randi() % 8
		var movement_vector = null
	
		match current_dir:
			Movement.LEFT:
				movement_vector = Vector2.LEFT
			Movement.RIGHT:
				movement_vector = Vector2.RIGHT
			Movement.UP:
				movement_vector = Vector2.UP
			Movement.DOWN:
				movement_vector = Vector2.DOWN
			_:
				pass
		
		if movement_vector:
			.move_state(delta, movement_vector * wanderMovement) 
			return true
	
	return false

func processWanderingState(delta):
	pass
	
func processMovement(delta):
	velocity = move_and_slide(velocity)
	
func _physics_process(delta):
	._physics_process(delta)
	decideState(delta)
	
	match state:
		State.IDLE:
			processIdleState(delta)
		State.CHASE:
			processChaseState(delta)
		State.WANDERING:
			processWanderingState(delta)
	
	processMovement(delta)
