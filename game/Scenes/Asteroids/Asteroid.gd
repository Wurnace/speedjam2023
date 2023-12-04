extends RigidBody2D

@onready var audiomaster = get_node("/root/AudioMaster")


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	audiomaster.play_sound("AsteroidImpact", global_position)
