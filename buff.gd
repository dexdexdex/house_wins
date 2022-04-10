extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buff_type = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_type(type):
	$buff_global.hide()
	$buff_single.hide()
	$delay_inevitable.hide()
	buff_type = type
	
	if type == "buff_global":
		$buff_global.show()
	elif type == "buff_single":
		$buff_single.show()
	elif type == "delay_inevitable":
		$delay_inevitable.show()
