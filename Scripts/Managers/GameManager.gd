extends Node

signal player_initialised

var player
var USER_DOCUMENTS_PATH = OS.get_environment("HOME") + "/Documents"
var LOCAL_INVENTORY_PATH = USER_DOCUMENTS_PATH + "/inventory.tres"

func _process(_delta):
	if not player:
		initialise_player()
		return
		
func initialise_player():
	player = get_tree().get_root().get_node("/root/World/Player")
	if not player:
		return
	
	emit_signal("player_initialised", player)
	
	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
	
	var existing_inventory = load(LOCAL_INVENTORY_PATH)
	if existing_inventory:
		player.inventory.set_items(existing_inventory.get_items())
	
func _on_player_inventory_changed(inventory):
	var result = ResourceSaver.save(LOCAL_INVENTORY_PATH, inventory)
	assert(result == OK)
