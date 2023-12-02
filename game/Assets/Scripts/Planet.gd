extends Node2D

@export var texturepath : CompressedTexture2D
@export var planetscale = 1.0

func setTexture(path: String):
	$Sprite.texture = load(path)


# Called when the node enters the scene tree for the first time.
func _ready():
	setTexture(texturepath.load_path)
	$Sprite.scale = Vector2(planetscale, planetscale)
	$Collision.scale = Vector2(planetscale, planetscale)
	$Highlight.scale = Vector2(planetscale + 0.05, planetscale + 0.05)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return delta

func _show_highlight():
	$Highlight.show()
	$HightlightTimeout.start()

func _on_hightlight_timeout_timeout():
	$Highlight.hide()
