extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var max_funds
var turn_count

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_text(turn_count, max_funds):
	$TurnCount.set_text("You survived "+str(turn_count)+" turns")
	$MaxFunds.set_text("You should have quit ahead while you had "+str(max_funds))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
