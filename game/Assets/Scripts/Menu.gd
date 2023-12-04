extends Node2D

var propspritetextureslength = 6
var propspritetextures = ["res://Assets/Sprites/Asteroids/Asteroid1.webp",
 "res://Assets/Sprites/Planets/DryPlanet.png",
 "res://Assets/Sprites/Planets/EggshellPlanet.png",
 "res://Assets/Sprites/Planets/PurplePlanet.png",
 "res://Assets/Sprites/Planets/Red Planet.png",
 "res://Assets/Sprites/Planets/Water Planet.png",
 "res://Assets/Sprites/Planets/PurplePlanet.png",
 "res://Assets/Sprites/Planets/IcePlanet.png"]

var background
@onready var pathfollow = $Path2D/PathFollow2D
@onready var propsprite = $Sprite2D
@onready var audiomaster = get_node("/root/AudioMaster")

# Called when the node enters the scene tree for the first time.
func _ready():
	background = $Background
	audiomaster.play_menu_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.global_rotation += 0.001
	propsprite.global_rotation -= 0.005
	pathfollow.progress += 75 * delta
	propsprite.position = pathfollow.global_position


func _on_visible_on_screen_notifier_2d_screen_exited():
	propsprite.texture = load(propspritetextures.pick_random())
	propsprite.rotation_degrees = randf_range(0, 360)


func _on_texture_button_pressed():
	audiomaster.play_sound("Click")
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_texture_button_2_pressed():
	audiomaster.play_sound("Click")
	get_tree().change_scene_to_file("res://Scenes/ScoreNoEdits.tscn")


func _on_texture_button_3_pressed():
	audiomaster.play_sound("Click")
	get_tree().change_scene_to_file("res://Scenes/Rules.tscn")
