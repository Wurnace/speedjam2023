extends Node2D

var background
var Planets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	background = $Background

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.global_rotation += 0.001

func PlayGame():
	get_tree().change_scene_to_packed(load("res://Scenes/Game.tscn"))
