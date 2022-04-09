extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var dice
export(PackedScene) var cash_in

# dice position index is current position of your cursor, goes from 1-6
var dice_position_index = 0
var dice_array = []

# this is our little toggle so that hitting right doesn't +71 dice_position_index within 3 milliseconds
var input_ok

func handle_hover():

	for i in 6:
		dice_array[i].hover = false
	
	dice_array[dice_position_index].hover = true
	

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in 6:
		var dice_instance = dice.instance()
		dice_instance.position = Vector2(300+100*i, 300)
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
	
	if(Input.is_action_pressed("ui_right") and input_ok == true and dice_position_index < 5):
		dice_position_index += 1
		handle_hover()
		input_ok = false

	if(Input.is_action_pressed("ui_left") and input_ok == true and dice_position_index > 0):
		dice_position_index -= 1
		handle_hover()
		input_ok = false
		
	if(Input.is_action_pressed("ui_accept") and input_ok == true):
		input_ok = false
		dice_array[dice_position_index].toggle()
		
	if(!(Input.is_action_pressed("ui_right")) and !(Input.is_action_pressed("ui_left")) and !(Input.is_action_pressed("ui_accept"))):
		input_ok = true
		
	pass
