extends "res://Scenes/Buttons/ClassButton.gd"

var rangerm_texture = load("res://Assets/characters/classes/rangerM.jpg")
var rangerf_texture = load("res://Assets/characters/classes/rangerF.jpg")

func _ready():
	self.set_normal_texture(rangerm_texture)

func _on_M_pressed():
	self.set_normal_texture(rangerm_texture)
	
func _on_F_pressed():
	self.set_normal_texture(rangerf_texture)
