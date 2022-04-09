extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var dice

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in 6:
		var dice_instance = dice.instance()
		dice_instance.position = Vector2(300+100*i, 300)
		add_child(dice_instance)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
