extends AudioStreamPlayer

const  menu_music = preload("res://res/asset/sound/bgm4.mp3")

func _play_music(music: AudioStream, volume = -10.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()

func _play_music_menu():
	_play_music(menu_music)

func _play_lvl_music(lvl_music):
	_play_music(lvl_music)

func play_fx(stream: AudioStream, volume = 0.0) :
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
