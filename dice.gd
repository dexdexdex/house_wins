extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# by default dice have 1 as value
var dice_value = 1
var rng = RandomNumberGenerator.new()

var is_held = false
var hover = false

# Called when the node enters the scene tree for the first time.
func roll_dice():
	dice_value = rng.randi_range(1,6)
	$dice_label.set_text(str(dice_value))
	$One.visible = false
	$Two.visible = false
	$Three.visible = false
	$Four.visible = false
	$Five.visible = false
	$Six.visible = false
	if dice_value == 1:
		$One.visible = true
	elif dice_value == 2:
		$Two.visible = true
	elif dice_value == 3:
		$Three.visible = true
	elif dice_value == 4:
		$Four.visible = true
	elif dice_value == 5:
		$Five.visible = true
	elif dice_value == 6:
		$Six.visible = true

func toggle():
	if(is_held == true):
		is_held = false
	else:
		is_held = true

	if(is_held == true):
		$selected.visible = true
		$HoldLabel.visible = true
	else:
		$selected.visible = false
		$HoldLabel.visible = false

	

func _ready():
	rng.randomize()
	roll_dice()
	$selected.visible = false
	$hover.visible = false
	$HoldLabel.visible = false
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(hover == false):
		$hover.visible = false
	else:
		$hover.visible = true
	pass
