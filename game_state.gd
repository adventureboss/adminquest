extends Node

export var player_stats = {
	max_health = 3,
	health = 3
}

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func _ready():
	player_stats.health = player_stats.max_health

func set_max_health(value):
	player_stats.max_health = value
	emit_signal("max_health_changed")

func set_health(value):
	player_stats.health = value
	emit_signal("health_changed", player_stats.health)
	if player_stats.health <= 0:
		emit_signal("no_health")
