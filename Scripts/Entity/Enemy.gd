extends "Entity.gd"

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

onready var playerDetection = get_node_or_null("PlayerDetectionZone")
onready var playerStopZone = get_node_or_null("StopZone")

# Following properties - Requires a PlayerDetectionZone
export(bool) var shouldFollow = false
export(float) var timeFollowingAfterLost = 2.0
export(bool) var shouldFollowAfterLost = true

# Wandering properties
export(bool) var shouldWander = true
export(float) var timeWandering = 1
export(float) var wanderMovement = 0.5
export(float) var delayBeforeNextWander = 1.0

# Knockback properties
var knockback_vector = Vector2.ZERO
export var knockback_force = 100
export var knockback_dur = .15
var current_knockback_dur = 0

var state = State.IDLE
onready var stats = $Stats
var timeSpentState = 0

onready var EnemyDeathEffect = preload("res://newEffects/BatEffect.tscn")

func _ready() -> void:
	._ready()
	if shouldFollow:
		assert(playerDetection != null, "If 'Should Follow' is set, a 'PlayerDetectionZone' is needed")

func _on_Hurtbox_area_entered(area: Area2D) -> void:
	stats.set_health(stats.health - 1)
	
	knockback_vector = (global_position - area.global_position).normalized() * knockback_force
	
	current_knockback_dur = knockback_dur

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
	var player = playerDetection.player
	var collisionShape: CollisionShape2D = player.get_node_or_null("CollisionShape2D")
	
	var playerPosition: Vector2
	
	if collisionShape != null:
		playerPosition = collisionShape.global_position
	else:
		playerPosition = player.global_position
		
	var direction = (playerPosition - global_position)
	
	if playerStopZone != null and playerStopZone.player == player:
		velocity = Vector2.ZERO
	elif playerStopZone == null and direction.length_squared() > 1:
		velocity = Vector2.ZERO
	else:
		.move_state(delta, direction.normalized())


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
	pass
	
func _physics_process(delta):
	if current_knockback_dur >= 0.0:
		var collision = move_and_slide(knockback_vector)
		current_knockback_dur -= delta
	else:
		knockback_vector = Vector2.ZERO
	
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

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect) 
	enemyDeathEffect.global_position = global_position
