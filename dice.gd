extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# by default dice have 1 as value
var dice_value = 1
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func roll_dice():
	dice_value = rng.randi_range(1,6)
	$dice_label.set_text(str(dice_value))

func _ready():
	rng.randomize()
	roll_dice()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
