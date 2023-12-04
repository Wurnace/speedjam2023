extends Node

func play_sound(name : String, position : Vector2 = Vector2(0, 0)):
	var sound = get_node(name)
	if position != Vector2(0, 0):
		sound.global_position = position
	elif sound is AudioStreamPlayer2D:
		sound.global_position = get_viewport().get_camera_2d().global_position
	sound.play()

func lerp_db(from_db: float, to_db: float, time: float, totalTime: float):
	return from_db + ((to_db - from_db) * (time / totalTime))

var interpFrameTime : float = 0
var currentlyPlaying
var changingMusic : bool = false
var InterpDuration : float = 1
var dir = [-80, 0]

func _process(delta):
	if not changingMusic: return

	currentlyPlaying.volume_db = lerp_db(dir[0], dir[1], interpFrameTime, InterpDuration)
	interpFrameTime += delta

func play_menu_music():
	if currentlyPlaying:
		interpFrameTime = 0
		dir = [0, -80]
		changingMusic = true
		currentlyPlaying = $GameMusic
		await get_tree().create_timer(InterpDuration).timeout
		$GameMusic.stop()
	if not $MenuMusic.playing:
		interpFrameTime = 0
		dir = [-80, 0]
		$MenuMusic.play()
		currentlyPlaying = $MenuMusic
		await get_tree().create_timer(InterpDuration).timeout
		changingMusic = false

func play_game_music():
	interpFrameTime = 0
	dir = [0, -80]
	changingMusic = true
	currentlyPlaying = $MenuMusic
	await get_tree().create_timer(InterpDuration).timeout
	$MenuMusic.stop()
	if not $GameMusic.playing:
		interpFrameTime = 0
		dir = [-80, 0]
		$GameMusic.play()
		currentlyPlaying = $GameMusic
		await get_tree().create_timer(InterpDuration).timeout
		changingMusic = false
