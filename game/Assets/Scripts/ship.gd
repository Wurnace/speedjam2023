extends RigidBody2D

signal connect_to_closest_body
signal connect_to_closest_body_really
signal disconnect
signal dying

@onready var magnet = $Sprite2D2

var dead = false
var maxspeed = 2000
var velmultiplier = 1
var velocityforward = 0
var velocitytotal = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not dead:
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
			angular_velocity = -2
		if Input.is_action_pressed("right"):
			angular_velocity = 2
		if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
			constant_torque = 0
			angular_velocity = 0
			rotation += 0.08
		if Input.is_action_pressed("connect"):
			emit_signal("connect_to_closest_body")
		if Input.is_action_pressed("connect_really"):
			emit_signal("connect_to_closest_body_really")
		if Input.is_action_pressed("disconnect"):
			emit_signal("disconnect")
		
		velocitytotal = Vector2(velocityforward, 0).rotated(rotation)
		linear_velocity = velocitytotal

func sleep(sec):
	await get_tree().create_timer(sec).timeout

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Planet": 
		body.destroy(null, $".", null, null, true)
	await sleep(0.05)
	if not (get_parent().get_parent().planetsLeft < 1):
		emit_signal("dying")
		dead = true
		$Sprite2D.hide()
		$Sprite2D2.hide()
		$CollisionShape2D.disabled = true
		$CPUParticles2D.emitting = true
