extends Node

export var player_stats = {
	max_health = 3,
	health = 3
}

signal show_dialogue(dialog_file, dialog_entry)
var _dialog_state: Dictionary = {}

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

func set_dialog_state(actor: String, variable: String, value):
	if not self._dialog_state.has(actor):
		self._dialog_state[actor] = {}

	self._dialog_state[actor][variable] = value

func get_dialog_state(actor: String, variable, default = null):
	if not self._dialog_state.has(actor):
		self._dialog_state[actor] = {}

	return self._dialog_state[actor].get(variable, default)

func show_dialogue(dialogue: Resource, entry: String):
	emit_signal("show_dialogue", dialogue, entry)
