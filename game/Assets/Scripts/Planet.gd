extends Node2D

var Debris = preload("res://Scenes/Debris.tscn")

func generateDebrisPts(radius, __translation: Vector2, length):
	var pts = []
	var rng = RandomNumberGenerator.new()
	for i in length:
		var angle = rng.randf_range(0, 2*PI)
		pts.push_back(Vector2(radius * sin(angle), radius * cos(angle)) + __translation)
	return pts

func destroy(area: Area2D):
	var center = (position + area.position) / 2
	var pts = generateDebrisPts(15, center,  25)
	
	var debrisInst = Debris.instantiate()
	debrisInst.position = (position + area.position) / 2
	
	debrisInst.get_node("Polygon2D").polygon = pts
	debrisInst.get_node("Polygon2D").position = center
	
	var shrunk_shapes = Geometry2D.offset_polygon(pts, -2)
	if shrunk_shapes.size() > 0:
		debrisInst.get_node("CollisionPolygon2D").polygon = shrunk_shapes[0]
	else:
		debrisInst.get_node("CollisionPolygon2D").polygon = pts
	
	debrisInst.get_node("CollisionPolygon2D").position = -center
	add_sibling(debrisInst)
	print(debrisInst)
	queue_free()

func setTexture(path: String):
	$Sprite.texture = load(path)


# Called when the node enters the scene tree for the first time.
func _ready():
	setTexture("res://Assets/Sprites/egPlanet.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return delta
