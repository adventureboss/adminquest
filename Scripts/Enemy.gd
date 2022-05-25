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

# Used for movement
export(int) var speed = 20

# Following properties
export(bool) var shouldFollow = true
export(float) var timeFollowingAfterLost = 2.0
export(bool) var shouldFollowAfterLost = true

# Wandering properties
export(bool) var shouldWander = true
export(float) var timeWandering = 1
export var wanderMovement = 0.5

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
	velocity = Vector2.ZERO
	
# Assume playerDetection is available on the chase state
func processChaseState(delta):
	var direction = (playerDetection.player.global_position - global_position).normalized()
	velocity = velocity.move_toward(direction * speed, acceleration * delta)

func shouldMoveToWandering(delta):
	if shouldWander:
		var current_dir = randi() % 8
		var movement_vector = null
	
		match current_dir:
			Movement.LEFT:
				movement_vector = Vector2(-1, 0.0)
			Movement.RIGHT:
				movement_vector = Vector2(1, 0.0)
			Movement.UP:
				movement_vector = Vector2(0.0, 1)
			Movement.DOWN:
				movement_vector = Vector2(0.0, -1)
			_:
				pass
		
		if movement_vector:
			.move_state(delta, movement_vector * wanderMovement) 
			return true

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
