extends Node2D

const AsteroidPathsExts = [1]

func setTexture(path: String):
	$Sprite.texture = load(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	setTexture("res://Assets/Sprites/Water Planet.png")

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
