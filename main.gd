extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var dice
export(PackedScene) var cash_in

# dice position index is current position of your cursor, goes from 1-6
var dice_position_index = 0
var dice_array = []

# if current funds = 0 then it's game over
var current_funds = 10000

# the house will inevitably win! Upkeep increases some amount per turn? Maybe geometrically?
var upkeep = 5

# this is our little toggle so that hitting right doesn't +71 dice_position_index within 3 milliseconds
var input_ok

func reroll_dice():
	for i in 6:
		if(dice_array[i].is_held == false):
			dice_array[i].roll_dice()

func handle_hover():

	for i in 6:
		dice_array[i].hover = false
	
	# dice position index 7 is reroll
	if(dice_position_index < 6):
		dice_array[dice_position_index].hover = true
		$reroll_button/reroll_text.visible = true
		$reroll_button/reroll_text_hover.visible = false
	
	if(dice_position_index == 6):
		$reroll_button/reroll_text.visible = false
		$reroll_button/reroll_text_hover.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in 6:
		var dice_instance = dice.instance()
		dice_instance.position = Vector2(100+100*i, 300)
		dice_array.append(dice_instance)
		add_child(dice_instance)
	
	# sorry this ist stupid at first
	var cash_in_instance = cash_in.instance()
	cash_in_instance.set_rule("ALL_SIXES")
	cash_in_instance.position = Vector2(100, 50)
	
	var cash_in_instance_2 = cash_in.instance()
	cash_in_instance_2.set_rule("ALL_FIVES")
	cash_in_instance_2.position = Vector2(200, 50)
	
	var cash_in_instance_3 = cash_in.instance()
	cash_in_instance_3.set_rule("ALL_FOURS")
	cash_in_instance_3.position = Vector2(300, 50)
	
	var cash_in_instance_4 = cash_in.instance()
	cash_in_instance_4.set_rule("ALL_THREES")	
	cash_in_instance_4.position = Vector2(400, 50)
	
	
	add_child(cash_in_instance)
	add_child(cash_in_instance_2)
	add_child(cash_in_instance_3)
	add_child(cash_in_instance_4)
	handle_hover()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_pressed("ui_right") and input_ok == true and dice_position_index < 6):
		dice_position_index += 1
		handle_hover()
		input_ok = false

	if(Input.is_action_pressed("ui_left") and input_ok == true and dice_position_index > 0):
		dice_position_index -= 1
		handle_hover()
		input_ok = false
		
	if(Input.is_action_pressed("ui_accept") and input_ok == true):
		input_ok = false
		if(dice_position_index < 6):
			dice_array[dice_position_index].toggle()
		else:
			# do reroll!
			reroll_dice()
			upkeep = upkeep * 1.25
			current_funds -= upkeep
			$upkeep_panel/upkeep_text.set_text(str("UPKEEP: $", int(upkeep)))
			$cash_panel/cash_text.set_text(str("FUNDS: $", int(current_funds)))
			pass
		
	if(!(Input.is_action_pressed("ui_right")) and !(Input.is_action_pressed("ui_left")) and !(Input.is_action_pressed("ui_accept"))):
		input_ok = true
		
	pass
