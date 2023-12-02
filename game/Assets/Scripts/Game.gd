extends Node2D

@onready var ship = $ShipContainer/Ship
@onready var pinjoint = $ShipContainer/Ship/Attachment
var planets
var targetplanet

# Called when the node enters the scene tree for the first time.
func _ready():
	planets = get_tree().get_nodes_in_group("planet")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):#
	if targetplanet:
		ship.magnet.look_at(targetplanet.global_position)
	
	_on_ship_connect_to_closest_body()


func _on_ship_connect_to_closest_body():
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
		prevplanet._show_highlight()


func _on_ship_connect_to_closest_body_really():
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
		pinjoint.global_position = prevplanet.global_position
		pinjoint.set_node_a(prevplanet.get_path())


func _on_ship_disconnect():
	pinjoint.set_node_a(ship.get_path())
