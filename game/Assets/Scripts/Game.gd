extends Node2D

@onready var ship = $ShipContainer/Ship
@onready var pinjoint = $ShipContainer/Ship/Attachment
@onready var global = get_node("/root/VarStorer")
var planets
var targetplanet
var lapsedtime = 0.0
var totalPlanets
@export var planetsLeft : int
var is_timing = true
var Winning = false
@onready var audiomaster = get_node("/root/AudioMaster")

# Called when the node enters the scene tree for the first time.
func _ready():
	planets = get_tree().get_nodes_in_group("planet")
	totalPlanets = planets.size()
	planetsLeft = totalPlanets
	audiomaster.play_game_music()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	if Input.is_action_just_pressed("reset"):
		global.WillShowInstructionsOnStart = false
		_on_reset_immeadieately_timeout()
	
	$CanvasLayer2.offset = ship.global_position
	if is_timing:
		lapsedtime += delta
	
	if targetplanet:
		var wr = weakref(targetplanet)
		if (wr.get_ref()):
			ship.magnet.look_at(targetplanet.global_position)
	
	_on_ship_connect_to_closest_body()
	
	var wr = weakref($CanvasLayer2/RichTextLabel)
	if wr.get_ref():
		var millsecs = int(fmod(lapsedtime, 1) * 1000)
		var secs = int(lapsedtime) % 60
		var mins = (int(lapsedtime) % (60 * 60)) / 60
		
		var timepassed = str(mins) + ":" + str(secs) + ":" + str(millsecs)
		$CanvasLayer2/RichTextLabel.text = timepassed


func _on_ship_connect_to_closest_body():
	var shippos = ship.global_position
	var prevplanet
	
	for node in planets:
		var wr = weakref(node)
		if (wr.get_ref()):
			node.distanceto = node.position.distance_to(shippos)
			if prevplanet:
				if node.position.distance_to(shippos) < prevplanet.position.distance_to(shippos) && node.position.distance_to(shippos) < 500:
					prevplanet = node
			elif node.position.distance_to(shippos) < 500:
				prevplanet = node
	
	if prevplanet:
		prevplanet._show_highlight()


func _on_ship_connect_to_closest_body_really():
	if targetplanet: return
	
	var shippos = ship.global_position
	var prevplanet
	
	for node in planets:
		var wr = weakref(node)
		if (wr.get_ref()):
			if prevplanet:
				if node.position.distance_to(shippos) < prevplanet.position.distance_to(shippos) && node.position.distance_to(shippos) < 500:
					prevplanet = node
			elif node.position.distance_to(shippos) < 500:
				prevplanet = node
	
	if prevplanet:
		targetplanet = prevplanet
		targetplanet.find_child("GravityFeild").monitoring = false
		pinjoint.global_position = prevplanet.global_position
		pinjoint.set_node_a(prevplanet.get_path())
		ship.magnet.visible = not ship.magnet.visible

func _on_ship_disconnect():
	if not targetplanet: return
	var wr = weakref(targetplanet)
	if (wr.get_ref()):
		targetplanet.find_child("GravityFeild").monitoring = true
	targetplanet = null
	pinjoint.set_node_a(ship.get_path())
	ship.magnet.visible = not ship.magnet.visible
	#print("DISC.")

func _on_reset_timeout():
	if not Winning:
		global.WillShowInstructionsOnStart = true
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_planet_dying(planet: RigidBody2D):
	audiomaster.play_sound("PlanetImpact", planet.global_position)
	planetsLeft -= 1
	if targetplanet == planet: _on_ship_disconnect()
	
	if planetsLeft == 0:
		global.time = $CanvasLayer2/RichTextLabel.text
		$WinDelay.start()


func _on_ship_dying():
	audiomaster.play_sound("ShipImpact")
	$Reset.start()


func _on_reset_immeadieately_timeout():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_win_delay_timeout():
		get_tree().change_scene_to_file("res://Scenes/Score.tscn")
