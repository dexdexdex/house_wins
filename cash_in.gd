extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rule_label_text
var rule_text

# default reward I guess?
var reward = 100

var main_node

var hover = false

# Called when the node enters the scene tree for the first time.
func _ready():
	main_node = get_node("main")
	pass # Replace with function body.

func set_rule(rule_string):
	$rule_label.set_text(str(rule_string))
	rule_text = rule_string

func check_rule(dice_array):
	if(rule_text == "ALL_SIXES"):
		if(dice_array[0] == 6 &&
			dice_array[1] == 6 &&
			dice_array[2] == 6 &&
			dice_array[3] == 6 &&
			dice_array[4] == 6 &&
			dice_array[5] == 6):
				main_node.current_funds += reward				
				return true
		else:
			return false

	if(rule_text == "ALL_FIVES"):
		if(dice_array[0] == 5 &&
			dice_array[1] == 5 &&
			dice_array[2] == 5 &&
			dice_array[3] == 5 &&
			dice_array[4] == 5 &&
			dice_array[5] == 5):
				main_node.current_funds += reward
				return true
		else:
			return false

	if(rule_text == "ALL_FOURS"):
		if(dice_array[0] == 4 &&
			dice_array[1] == 4 &&
			dice_array[2] == 4 &&
			dice_array[3] == 4 &&
			dice_array[4] == 4 &&
			dice_array[5] == 4):
				main_node.current_funds += reward
				return true
		else:
			return false

	if(rule_text == "ALL_THREES"):
		if(dice_array[0] == 3 &&
			dice_array[1] == 3 &&
			dice_array[2] == 3 &&
			dice_array[3] == 3 &&
			dice_array[4] == 3 &&
			dice_array[5] == 3):
				main_node.current_funds += reward
				return true
		else:
			return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(hover == false):
		$hover.visible = false
	else:
		$hover.visible = true
	pass
