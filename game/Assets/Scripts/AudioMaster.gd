extends Node

func play_sound(name : String, position : Vector2 = Vector2(0, 0)):
	var sound = get_node(name)
	if position != Vector2(0, 0):
		sound.global_position = position
	elif sound is AudioStreamPlayer2D:
		sound.global_position = get_viewport().get_camera_2d().global_position
	sound.play()

func play_menu_music():
	$GameMusic.stop()
	if not $MenuMusic.playing:
		$MenuMusic.play()
		
func play_game_music():
	$MenuMusic.stop()
	if not $GameMusic.playing:
		$GameMusic.play()
