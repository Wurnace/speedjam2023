extends Node2D

<<<<<<< HEAD
const AsteroidPathsExts = [1]
=======
@export var texturepath : CompressedTexture2D
@export var planetscale = 1.0
>>>>>>> 5284a40588c9f9c2e5fdcf3da37b197107c8f48f

func setTexture(path: String):
	$Sprite.texture = load(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	setTexture(texturepath.load_path)
	$Sprite.scale = Vector2(planetscale, planetscale)
	$Collision.scale = Vector2(planetscale, planetscale)
	$Highlight.scale = Vector2(planetscale + 0.05, planetscale + 0.05)

<<<<<<< HEAD
var isDead : bool = false
func _process(_delta):
	if isDead: queue_free()

var asteroids = {}
var asteroidPaths = []
func spawnAsteroid(filepath: String):
	if not asteroids[filepath]:
		asteroids[filepath] = load(filepath)
	
	var inst = asteroids[filepath].new()
	get_parent().add_child(inst)
	return inst

func registerAsteroids():
	asteroidPaths = []
	for ext in AsteroidPathsExts:
		asteroidPaths.push_back("res://Scenes/Asteroids/Asteroid1" + str(ext) + ".tscn")
	return asteroidPaths

func destroy(area: Area2D):
	var rng = RandomNumberGenerator.new()
	registerAsteroids()
	for i in rng.randi_range(2, 9):
		var current_asteroid_path = asteroidPaths[rng.randi_range(0, asteroidPaths.size())]
		spawnAsteroid(current_asteroid_path)
	isDead = true
=======
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return delta

func _show_highlight():
	$Highlight.show()
	$HightlightTimeout.start()

func _on_hightlight_timeout_timeout():
	$Highlight.hide()
>>>>>>> 5284a40588c9f9c2e5fdcf3da37b197107c8f48f
