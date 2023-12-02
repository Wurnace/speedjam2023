extends Node2D

func setTexture(path: String):
	$Sprite.texture = load(path)


# Called when the node enters the scene tree for the first time.
func _ready():
	setTexture("res://Assets/Sprites/egPlanet.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return delta
