extends Node2D

var background

# Called when the node enters the scene tree for the first time.
func _ready():
	background = $Background


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.global_rotation += 0.001
