extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var dice
export(PackedScene) var cash_in
export(PackedScene) var game_over_scene

# dice position index is current position of your cursor, goes from 1-6
var dice_position_index = 0
var dice_array = []

# cash in index position is where we do hover overing of cash in tiles
var cash_in_index = 0
var cash_in_array = []

# if current funds = 0 then it's game over
var current_funds = 10000

# the house will inevitably win! Upkeep increases some amount per turn? Maybe geometrically?
var upkeep = 5

# this is our little toggle so that hitting right doesn't +71 dice_position_index within 3 milliseconds
var input_ok

var dice_select_mode = true
var cash_in_mode = false

var turn_count = 0
var max_funds = current_funds
var game_over = false



var rng = RandomNumberGenerator.new()

func reroll_dice():
	for i in 6:
		if(dice_array[i].is_held == false):
			dice_array[i].roll_dice()

func handle_cash_in_hover():
	for i in 4:	
		cash_in_array[i].hover = false
	
	if(cash_in_mode == true):
		cash_in_array[cash_in_index].hover = true
		
	pass

func handle_dice_hover():

	for i in 6:
		dice_array[i].hover = false

	if(dice_select_mode == true):	
		print('yup yup in dicey dice')
		# dice position index 7 is reroll
		if(dice_position_index < 6):
			dice_array[dice_position_index].hover = true
			$reroll_button/reroll_text.visible = true
			$reroll_button/reroll_text_hover.visible = false
		
		if(dice_position_index == 6):
			$reroll_button/reroll_text.visible = false
			$reroll_button/reroll_text_hover.visible = true

	else:
		print('nope we are in cash in mode')

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in 6:
		var dice_instance = dice.instance()
		dice_instance.dice_value = i + 1
		dice_instance.position = Vector2(100+100*i, 300)
		dice_array.append(dice_instance)
		add_child(dice_instance)
	
	# sorry this ist stupid at first
	var cash_in_instance = cash_in.instance()
	cash_in_instance.set_rule("ALL_SIXES")
	cash_in_instance.set_label("All sixes")
	cash_in_instance.position = Vector2(100, 50)
	cash_in_instance.set_reward(rng.randi_range(400, 600))
	
	var cash_in_instance_2 = cash_in.instance()
	cash_in_instance_2.set_rule("ALL_FIVES")
	cash_in_instance_2.set_label("All fives")
	cash_in_instance_2.position = Vector2(200, 50)
	cash_in_instance_2.set_reward(rng.randi_range(400, 600))
	
	var cash_in_instance_3 = cash_in.instance()
	cash_in_instance_3.set_rule("ALL_FOURS")
	cash_in_instance_3.set_label("All fours")
	cash_in_instance_3.position = Vector2(300, 50)
	cash_in_instance_3.set_reward(rng.randi_range(400, 600))
	
	var cash_in_instance_4 = cash_in.instance()
	cash_in_instance_4.set_rule("ALL_THREES")	
	cash_in_instance_4.set_label("All threes")
	cash_in_instance_4.position = Vector2(400, 50)
	cash_in_instance_4.set_reward(rng.randi_range(400, 600))
	
	
	add_child(cash_in_instance)
	add_child(cash_in_instance_2)
	add_child(cash_in_instance_3)
	add_child(cash_in_instance_4)
	
	cash_in_array.append(cash_in_instance)
	cash_in_array.append(cash_in_instance_2)
	cash_in_array.append(cash_in_instance_3)
	cash_in_array.append(cash_in_instance_4)
	

	handle_dice_hover()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if(Input.is_action_pressed("ui_right") and input_ok == true):
		if(dice_select_mode == true and dice_position_index < 6):
			dice_position_index += 1
			handle_dice_hover()
		elif(cash_in_mode == true and cash_in_index < 3):
			cash_in_index += 1
			handle_cash_in_hover()
		
		input_ok = false

	if(Input.is_action_pressed("ui_left") and input_ok == true):
		if(dice_select_mode == true and dice_position_index > 0):
			dice_position_index -= 1
			handle_dice_hover()
		elif(cash_in_mode == true and cash_in_index > 0):
			cash_in_index -= 1
			handle_cash_in_hover()
		
		input_ok = false

	if(Input.is_action_pressed("ui_up") and input_ok == true):
		cash_in_mode = true
		dice_select_mode = false
		handle_dice_hover()
		handle_cash_in_hover()
		
		input_ok = false

	if(Input.is_action_pressed("ui_down") and input_ok == true):
		cash_in_mode = false
		dice_select_mode = true
		dice_position_index = 0
		handle_dice_hover()
		handle_cash_in_hover()
		
		
		input_ok = false

		
	if(Input.is_action_pressed("ui_accept") and input_ok == true):
		if game_over:
			get_tree().reload_current_scene()
		input_ok = false
		if cash_in_mode:
			# If matches constraint
			if cash_in_array[cash_in_index].check_rule(dice_array):
				current_funds += cash_in_array[cash_in_index].reward
				
				for i in 6:
					if(dice_array[i].is_held == true):
						dice_array[i].toggle()
				reroll_dice()
				$cash_panel/cash_text.set_text(str("FUNDS: $", int(current_funds)))
			return
			
			
		if(dice_position_index < 6):
			dice_array[dice_position_index].toggle()
		else:
			# do reroll!
			reroll_dice()
			turn_count += 1
			if current_funds > max_funds:
				max_funds = current_funds
			current_funds -= upkeep
			if current_funds < 0:
				game_over = true
				var scene = game_over_scene.instance()
				add_child(scene)
				scene.set_text(turn_count, max_funds)
			upkeep = stepify(upkeep * 1.25, 1)
			$upkeep_panel/upkeep_text.set_text(str("UPKEEP: $", int(upkeep)))
			$cash_panel/cash_text.set_text(str("FUNDS: $", int(current_funds)))
			pass
		
	if(!(Input.is_action_pressed("ui_right")) and !(Input.is_action_pressed("ui_left")) and !(Input.is_action_pressed("ui_accept"))):
		input_ok = true
		
	pass
