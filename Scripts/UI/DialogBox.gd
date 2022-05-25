extends Control

signal actioned(next_id)

const Line = preload("res://addons/dialogue_manager/dialogue_line.gd")

onready var actor  = $BubbleTexture/Margin/Rows/Actor
onready var content = $BubbleTexture/Margin/Rows/Content

var dialogue: Line

func _ready():
	self.visible = false
	
	if not dialogue:
		queue_free()
		return
		
	if dialogue.character != "":
		actor.visible = true
		actor.bbcode_text = dialogue.character
	else:
		actor.visible = false
		
	content.dialogue = dialogue
	
	self.visible = true
	
	content.type_out()
	yield(content, "finished")
	
	var next_id: String = ""
	while true:
		if Input.is_action_just_pressed("interact"):
			next_id = dialogue.next_id
			break
		yield(get_tree(), "idle_frame")
		
	emit_signal("actioned", next_id)
	queue_free()
