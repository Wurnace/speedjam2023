extends Node

@onready var global = get_node("/root/VarStorer")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed() or not global.WillShowInstructionsOnStart:
		global.WillShowInstructionsOnStart = true
		get_tree().paused = false
		$Fade.hide()
		$Instructions.hide()
