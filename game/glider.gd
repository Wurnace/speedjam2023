extends StaticBody3D

var rest_angle = Vector3.ZERO
var speed = 10
var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("pivot_up"):
		rotation.x += 1
	if Input.is_action_pressed("pivot_down"):
		rotation.x -= 1
	
	position += _calculate_velocity(speed) * delta
	
	

func _calculate_velocity(speedin):
	var angle = rotation.x
	var outvel
	outvel = Vector3(0, angle, speedin*angle)
	return outvel
