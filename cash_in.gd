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
	rule_text = rule_string

func set_label(rule_label_text):
	rule_label_text = rule_label_text
	$rule_label.set_text(str(rule_label_text))

func set_reward(new_reward):
	reward = new_reward
	$reward_label.set_text(str(new_reward))

func check_rule(dice_array):
	if(rule_text == "ALL_SIXES"):
		if(dice_array[0].dice_value == 6 &&
			dice_array[1].dice_value == 6 &&
			dice_array[2].dice_value == 6 &&
			dice_array[3].dice_value == 6 &&
			dice_array[4].dice_value == 6 &&
			dice_array[5].dice_value == 6):			
				return true
		else:
			return false

	if(rule_text == "ALL_FIVES"):
		if(dice_array[0].dice_value == 5 &&
			dice_array[1].dice_value == 5 &&
			dice_array[2].dice_value == 5 &&
			dice_array[3].dice_value == 5 &&
			dice_array[4].dice_value == 5 &&
			dice_array[5].dice_value == 5):
				return true
		else:
			return false

	if(rule_text == "ALL_FOURS"):
		if(dice_array[0].dice_value == 4 &&
			dice_array[1].dice_value == 4 &&
			dice_array[2].dice_value == 4 &&
			dice_array[3].dice_value == 4 &&
			dice_array[4].dice_value == 4 &&
			dice_array[5].dice_value == 4):
				return true
		else:
			return false

	if(rule_text == "ALL_THREES"):
		if(dice_array[0].dice_value == 3 &&
			dice_array[1].dice_value == 3 &&
			dice_array[2].dice_value == 3 &&
			dice_array[3].dice_value == 3 &&
			dice_array[4].dice_value == 3 &&
			dice_array[5].dice_value == 3):
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

