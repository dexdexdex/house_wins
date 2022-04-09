extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var dice
export(PackedScene) var cash_in


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in 6:
		var dice_instance = dice.instance()
		dice_instance.position = Vector2(300+100*i, 300)
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
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
