extends Area2D

var maxspeed = 500
var velmultiplier = 1
var velocityforward = 0
var velocitytotal = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("acc") && velocityforward < maxspeed:
		if velocityforward + velmultiplier < maxspeed:
			velocityforward += velmultiplier
			velmultiplier += 1
		else:
			velocityforward += 1
	if Input.is_action_pressed("deacc") && velocityforward > 0:
		if velocityforward - velmultiplier > 0:
			velocityforward -= velmultiplier
			velmultiplier += 1
		else:
			velocityforward -= 1
	if Input.is_action_just_released("acc") or Input.is_action_just_released("deacc"):
		velmultiplier = 0
	if Input.is_action_pressed("left"):
		rotation -= 0.08
	if Input.is_action_pressed("right"):
		rotation += 0.08
	
	velocitytotal = Vector2(velocityforward, 0).rotated(rotation)
	position += velocitytotal * delta
