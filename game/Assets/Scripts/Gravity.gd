extends Area2D

var affectedBodies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for node in affectedBodies:
		var wr = weakref(node)
		if (wr.get_ref()):
			#print(node.name)
			if node.name == "Ship":
				node.linear_velocity += -(node.global_position - global_position) * 0.1
			elif node.get_class() == "RigidBody2D":
				node.linear_velocity += -(node.global_position - global_position) * 0.01

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body == get_parent(): return
	affectedBodies.push_back(body)

func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body in affectedBodies:
		var indx = affectedBodies.find(body)
		affectedBodies.remove_at(indx)
