#dialoguebox.gd
extends RichTextLabel

var dialog = ["Heya, Welcome to the game!", "Are you ready to go through your eventful day?"]
var page = 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	 # Replace with function body.

func _input(event):
	if Input.is_mouse_button_pressed(1):
		if get_visible_characters() > get_total_character_count():
			if page < (dialog.size() - 1):
				page +=1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() +1) # Replace with function body.
