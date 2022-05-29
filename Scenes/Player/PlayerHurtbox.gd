extends Area2D

var invincible = false setget set_invincible

signal invincibility_started
signal invincibility_ended

onready var timer = $Timer
onready var collision = $CollisionShape2D

func set_invincible(value):
	invincible = value
	if invincible:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
	
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	
func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invincibility_ended():
	collision.set_deferred("disabled", false)
	print("ended")

func _on_Hurtbox_invincibility_started():
	collision.set_deferred("disabled", true)
	print("started")
