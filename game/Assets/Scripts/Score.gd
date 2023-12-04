extends Node2D

const SAVE_FILE = "user://savedtimes"

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
@onready var global = get_node("/root/VarStorer")
@onready var audiomaster = get_node("/root/AudioMaster")

# Called when the node enters the scene tree for the first time.
func _ready():
	audiomaster.play_menu_music()
	background = $Background
	$Sprite2D2/CurrentTimes.text = global.time
	if return_saved_data() is Dictionary:
		var data = return_saved_data()
		$Sprite2D2/Names.text = data["names"]
		$Sprite2D2/Times.text = data["times"]

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
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")


func _on_save_button_pressed():
	audiomaster.play_sound("Click")
	if $Sprite2D2/NameEnter.text != "":
		$Sprite2D2/NameEnter.editable = false
		$Sprite2D2/SaveButton.disabled = true
		$Sprite2D2/Names.text = $Sprite2D2/NameEnter.text + "\n" + $Sprite2D2/Names.text
		$Sprite2D2/Times.text = $Sprite2D2/CurrentTimes.text + "\n" + $Sprite2D2/Times.text
		save_data()


func get_data():
	var save_dict = {
		"names": $Sprite2D2/Names.text,
		"times": $Sprite2D2/Times.text
	}
	return save_dict

func save_data():
	var save_game = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	
	var json_string = JSON.stringify(get_data())
	
	save_game.store_line(json_string)

func return_saved_data():
	var file = FileAccess.file_exists(SAVE_FILE)
	if not file:
		return 0
	
	var save_game = FileAccess.open(SAVE_FILE, FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		return node_data
