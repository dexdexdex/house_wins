extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var shop_index = 0
var input_ok = true

var main_node
# this is some weird timing thing because both main node and shop node want to press enter so we wait .3 second
var can_select_shop = false

# Called when the node enters the scene tree for the first time.
func _ready():
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
		self.visible = false
		input_ok = false

	if(!(Input.is_action_pressed("ui_right")) and !(Input.is_action_pressed("ui_left")) and !(Input.is_action_pressed("ui_accept"))):
		input_ok = true

func start_timer():
	$ready_timer.start()


func _on_ready_timer_timeout():
	can_select_shop = true
	pass # Replace with function body.
