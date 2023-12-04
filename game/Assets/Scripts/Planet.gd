extends Node2D

@export var texturepath : CompressedTexture2D
@export var planetscale = 1.0
@export var grabbed : bool = false

const AsteroidPathsIDs = [1]
@export var asteroids = {} # Referenced asteroids' paths

var distanceto = 0

signal dying

func setTexture(path: String):
	$Sprite.texture = load(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	setTexture(texturepath.load_path)
	$Sprite.scale = Vector2(planetscale, planetscale)
	$Collision.scale = Vector2(planetscale, planetscale)
	$Highlight.scale = Vector2(planetscale + 0.1, planetscale + 0.1)
	$GravityFeild.scale = Vector2(planetscale, planetscale)
	$VisibleOnScreenNotifier2D.scale = Vector2(planetscale, planetscale)
	$OffScreenIndicator.sprite.texture = $Sprite.texture

func _show_highlight():
	$Highlight.show()
	$HightlightTimeout.start()

func _on_hightlight_timeout_timeout():
	$Highlight.hide()

@export var isDead : bool = false
func _process(_delta):
	if isDead:
		emit_signal("dying", $".")
		queue_free()
	$OffScreenIndicator.look_at(global_position)
	$OffScreenIndicator.distanceto = distanceto

func spawnAsteroid(filepath: String, totalToSpawn: int, rng: RandomNumberGenerator):
	if not filepath in asteroids:
		asteroids[filepath] = load(filepath)
	
	var deviation = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))
	var inst = asteroids.get(filepath).instantiate()
	inst.position = position + deviation
	
	var rand_scale = (rng.randf_range(-0.3, 0.3) + planetscale) / totalToSpawn
	var size = Vector2(rand_scale, rand_scale)
	inst.get_node("Collision").scale = size
	inst.get_node("Sprite").scale = size
	call_deferred("add_sibling", inst)
	return inst

var asteroidPaths = []
func registerAsteroids():
	asteroidPaths = []
	for ext in AsteroidPathsIDs:
		asteroidPaths.push_back("res://Scenes/Asteroids/Asteroid" + str(ext) + ".tscn")
	return asteroidPaths

func destroy(_a, body, _c, _d, _BLAH: bool = true):
	if isDead: return
	if not _BLAH:
		if body.name != "Planet": return
		body.destroy(null, null, null, null, true)
	
	var rng = RandomNumberGenerator.new()
	registerAsteroids()
	
	var amount = rng.randi_range(1, 3)
	for i in amount:
		var current_asteroid_path = asteroidPaths[rng.randi_range(0, asteroidPaths.size()-1)]
		spawnAsteroid(current_asteroid_path, amount, rng)
	isDead = true

func _on_visible_on_screen_notifier_2d_screen_entered():
	var wr = weakref($OffScreenIndicator.sprite)
	if wr.get_ref():
		$OffScreenIndicator.sprite.hide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	var wr = weakref($OffScreenIndicator.sprite)
	if wr.get_ref():
		$OffScreenIndicator.sprite.show()
