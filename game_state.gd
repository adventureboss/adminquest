extends Node

# Chose hours for the currency, soooo funny.
export var player_stats = {
	max_health = 3,
	health = 3,
	hours = 0
}

# establish defautl dictionary for dialogue states
var _dialogue_state: Dictionary = {}
var _quest_state: Dictionary = {}

signal no_health
signal health_changed(value)
signal max_health_changed(value)
signal hours_changed(value)

var game

export var current_scene_name = "Title Screen" setget scene_change

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
	
# Scene change handling
func scene_change(name):
	current_scene_name = name
	
func start_dialogue(resource, entry) -> void:
	DialogueManager.game_states = [self]
	get_tree().paused = true
	var dialogue = yield(DialogueManager.get_next_dialogue_line(entry, resource), "completed")
	if dialogue != null:
		var balloon = preload("res://Scenes/Dialogue/example_balloon.tscn").instance()
		balloon.dialogue = dialogue
		get_tree().current_scene.add_child(balloon)
		start_dialogue(resource, yield(balloon, "actioned"))
	else:
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


# handle dialog states
func set_dialogue_state(actor: String, variable: String, value):
	if not self._dialogue_state.has(actor):
		self._dialogue_state[actor] = {}

	self._dialogue_state[actor][variable] = value

func get_dialogue_state(actor: String, variable, default = null):
	if not self._dialogue_state.has(actor):
		self._dialogue_state[actor] = {}

	return self._dialogue_state[actor].get(variable, default)

# handle player quest states
func set_quest_state(quest: String, variable: String, value):
	if not self._quest_state.has(quest):
		self._quest_state[quest] = {}
	
	self._quest_state[quest][variable] = value

func get_quest_state(quest: String, variable, default = null):
	if not self._quest_state.has(quest):
		self._quest_state[quest] = {}
		
	return self._quest_state[quest].get(variable, default)
