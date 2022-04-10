extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var shop_index = 0
var input_ok = true

var main_node
# this is some weird timing thing because both main node and shop node want to press enter so we wait .3 second
var can_select_shop = false

var reward_array = []
var rng = RandomNumberGenerator.new()


func generate_reward():
	var reward_index = rng.randi_range(0,2)
	if(reward_index == 0):
		return {"type":"buff_global", "amount":rng.randi_range(30,80)}
	if(reward_index == 1):
		return {"type":"buff_single", "amount":rng.randi_range(40,80)}
	if(reward_index == 2):
		return {"type":"delay_inevitable", "amount":rng.randi_range(25,50)}

func generate_options():
	var option_object = generate_reward()

	# i think there's some weird $ variable notation you could do but for now we are doing it manually
	if(option_object.type == "buff_global"):
		$shop_panel/option_1_label.set_text(str("Global Gold  +", option_object.amount, '%'))
	if(option_object.type == "buff_single"):
		$shop_panel/option_1_label.set_text(str("Improve Reward +", option_object.amount, '%'))
	if(option_object.type == "delay_inevitable"):
		$shop_panel/option_1_label.set_text(str("Upkeep -", option_object.amount, '%'))

	###############

	option_object = generate_reward()
	if(option_object.type == "buff_global"):
		$shop_panel/option_2_label.set_text(str("Global Gold  +", option_object.amount, '%'))
	if(option_object.type == "buff_single"):
		$shop_panel/option_2_label.set_text(str("Improve Reward +", option_object.amount, '%'))
	if(option_object.type == "delay_inevitable"):
		$shop_panel/option_2_label.set_text(str("Upkeep -", option_object.amount, '%'))


	#####################
	option_object = generate_reward()
	if(option_object.type == "buff_global"):
		$shop_panel/option_3_label.set_text(str("Global Gold  +", option_object.amount, '%'))
	if(option_object.type == "buff_single"):
		$shop_panel/option_3_label.set_text(str("Improve Reward +", option_object.amount, '%'))
	if(option_object.type == "delay_inevitable"):
		$shop_panel/option_3_label.set_text(str("Upkeep -", option_object.amount, '%'))

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$shop_panel/option_1.visible = false
	$shop_panel/option_1_selected.visible = false
	$shop_panel/option_2.visible = false
	$shop_panel/option_2_selected.visible = false
	$shop_panel/option_3.visible = false
	$shop_panel/option_3_selected.visible = false
	
	main_node = get_node("/root/main")
	
	handle_hover_highlight()
	pass # Replace with function body.

func handle_hover_highlight():
	
	if(shop_index == 0):
		$shop_panel/option_1.visible = false
		$shop_panel/option_1_selected.visible = true
		$shop_panel/option_2.visible = true
		$shop_panel/option_2_selected.visible = false
		$shop_panel/option_3.visible = true
		$shop_panel/option_3_selected.visible = false

	if(shop_index == 1):
		$shop_panel/option_1.visible = true
		$shop_panel/option_1_selected.visible = false
		$shop_panel/option_2.visible = false
		$shop_panel/option_2_selected.visible = true
		$shop_panel/option_3.visible = true
		$shop_panel/option_3_selected.visible = false		

	if(shop_index == 2):
		$shop_panel/option_1.visible = true
		$shop_panel/option_1_selected.visible = false
		$shop_panel/option_2.visible = true
		$shop_panel/option_2_selected.visible = false
		$shop_panel/option_3.visible = false
		$shop_panel/option_3_selected.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	
	if(Input.is_action_pressed("ui_right") and input_ok == true):
		if(shop_index < 3):
			shop_index += 1
			handle_hover_highlight()
		
		input_ok = false

	if(Input.is_action_pressed("ui_left") and input_ok == true):
		if(shop_index > 0):
			shop_index -= 1
			handle_hover_highlight()
		
		input_ok = false

	if(Input.is_action_pressed("ui_accept") and input_ok == true and can_select_shop == true):
		main_node.in_shop = false
		can_select_shop = false
		print('selected ', shop_index, ' for purchase!')
		var reward = generate_reward()
		print('reward is ', reward.type, ' and amount is ', reward.amount)
		self.visible = false
		input_ok = false

	if(!(Input.is_action_pressed("ui_right")) and !(Input.is_action_pressed("ui_left")) and !(Input.is_action_pressed("ui_accept"))):
		input_ok = true

func start_timer():
	$ready_timer.start()

func _on_ready_timer_timeout():
	can_select_shop = true
	pass # Replace with function body.
