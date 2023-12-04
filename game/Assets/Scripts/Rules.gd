extends Node2D

func TitleScreen():
	get_tree().change_scene_to_packed(load("res://Scenes/Menu.tscn"))
