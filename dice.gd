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

func toggle():
	if(is_held == true):
		is_held = false
	else:
		is_held = true

	if(is_held == true):
		$selected.visible = true
	else:
		$selected.visible = false

func _ready():
	rng.randomize()
	roll_dice()
	$selected.visible = false
	$hover.visible = false
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(hover == false):
		$hover.visible = false
	else:
		$hover.visible = true
	pass
