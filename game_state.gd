extends Node

# Chose hours for the currency, soooo funny.
export var player_stats = {
	max_health = 3,
	health = 3,
	hours = 0
}

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal hours_changed(value)

var game

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

func set_hours(value):
	player_stats.hours = value
	emit_signal("hours_changed", player_stats.hours)
	if player_stats.hours <= 0:
		emit_signal("no_hours")
		
func increase_hours(by):
	set_hours(player_stats.hours + by)

func start_dialogue(resource, entry) -> void:
	get_tree().paused = true
	var dialogue = yield(DialogueManager.get_next_dialogue_line(entry, resource), "completed")
	if dialogue != null:
		var balloon = preload("res://Scenes/Dialogue/example_balloon.tscn").instance()
		balloon.dialogue = dialogue
		get_tree().current_scene.add_child(balloon)
		start_dialogue(resource, yield(balloon, "actioned"))
	get_tree().paused = false

func save_game(filename: String):
	var save_data: Dictionary = {
		player = {
			stats = player_stats
		}
	}

	var file = File.new()
	file.open(filename, File.WRITE)
	file.store_var(save_data, true)
	file.close()

func load_game(filename: String):
	var file = File.new()
	if file.file_exists(filename):
		file.open(filename, File.READ)
		var game_data = file.get_var()
		file.close()
		
		player_stats = game_data.player.stats

		return true
	else:
		return false
