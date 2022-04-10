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

var rule_array = []
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	main_node = get_node("main")
	
	rule_array.append({"rule_text": "ALL_SIXES", "rule_string": "All Sixes"})
	rule_array.append({"rule_text": "ALL_FIVES", "rule_string": "All Fives"})	
	rule_array.append({"rule_text": "ALL_FOURS", "rule_string": "All Fours"})	
	rule_array.append({"rule_text": "ALL_THREES", "rule_string": "All Threes"})	
	rule_array.append({"rule_text": "ALL_TWOS", "rule_string": "All Twos"})	
	rule_array.append({"rule_text": "ALL_ONES", "rule_string": "All Ones"})	
	rule_array.append({"rule_text": "ALL_EVENS", "rule_string": "All Evens"})	
	rule_array.append({"rule_text": "ALL_ODDS", "rule_string": "All Odds"})	
	rule_array.append({"rule_text": "THREE+_ODDS", "rule_string": "3+ Odds"})	
	rule_array.append({"rule_text": "FOUR+_ODDS", "rule_string": "4+ Odds"})	
	rule_array.append({"rule_text": "FIVE+_ODDS", "rule_string": "5+ Odds"})	
	rule_array.append({"rule_text": "THREE+_EVENS", "rule_string": "3+ Evens"})		
	rule_array.append({"rule_text": "FOUR+_EVENS", "rule_string": "4+ Evens"})	
	rule_array.append({"rule_text": "FIVE+_EVENS", "rule_string": "5+ Evens"})	
	
	pass # Replace with function body.

func set_rule(rule_string):
	rule_text = rule_string

func set_label(rule_label_text):
	rule_label_text = rule_label_text
	$rule_label.set_text(str(rule_label_text))

func set_reward(new_reward):
	reward = new_reward
	$reward_label.set_text(str(new_reward))

func change_rule():
	var rule_index = rng.randi_range(0, rule_array.size() - 1)
	set_rule(rule_array[rule_index].rule_text)
	set_label(rule_array[rule_index].rule_string)
	
	pass

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

	if(rule_text == "ALL_TWOS"):
		if(dice_array[0].dice_value == 2 &&
			dice_array[1].dice_value == 2 &&
			dice_array[2].dice_value == 2 &&
			dice_array[3].dice_value == 2 &&
			dice_array[4].dice_value == 2 &&
			dice_array[5].dice_value == 2):
				return true
		else:
			return false

	if(rule_text == "ALL_ONES"):
		if(dice_array[0].dice_value == 1 &&
			dice_array[1].dice_value == 1 &&
			dice_array[2].dice_value == 1 &&
			dice_array[3].dice_value == 1 &&
			dice_array[4].dice_value == 1 &&
			dice_array[5].dice_value == 1):
				return true
		else:
			return false

	if(rule_text == "ALL_EVENS"):
		for i in dice_array:
			if i.dice_value % 2 == 1:
				return false
		
		return true

	if(rule_text == "ALL_ODDS"):
		for i in dice_array:
			if i.dice_value % 2 == 0:
				return false
		
		return true

	if(rule_text == "THREE+_ODDS"):
		var odd_count = 0
		for i in dice_array:
			if i.dice_value % 2 == 1:
				odd_count += 1
		
		if(odd_count >= 3):
			return true
		else:
			return false


	if(rule_text == "FOUR+_ODDS"):
		var odd_count = 0
		for i in dice_array:
			if i.dice_value % 2 == 1:
				odd_count += 1
		
		if(odd_count >= 4):
			return true
		else:
			return false


	if(rule_text == "FIVE+_ODDS"):
		var odd_count = 0
		for i in dice_array:
			if i.dice_value % 2 == 1:
				odd_count += 1
		
		if(odd_count >= 5):
			return true
		else:
			return false


	if(rule_text == "THREE+_EVENS"):
		var even_count = 0
		for i in dice_array:
			if i.dice_value % 2 == 0:
				even_count += 1
		
		if(even_count >= 3):
			return true
		else:
			return false

	if(rule_text == "FOUR+_EVENS"):
		var even_count = 0
		for i in dice_array:
			if i.dice_value % 2 == 0:
				even_count += 1
		
		if(even_count >= 4):
			return true
		else:
			return false

	if(rule_text == "FIVE+_EVENS"):
		var even_count = 0
		for i in dice_array:
			if i.dice_value % 2 == 0:
				even_count += 1
		
		if(even_count >= 5):
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

