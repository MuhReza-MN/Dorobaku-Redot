class_name HomeMenu extends Node

@onready var loading: CanvasLayer = $loading

func _ready() -> void:
	AudioPlayer._play_music_menu()
	$loading.visible = true

func _press_btnSetting() -> void:
	print("setting")

func _press_btnPlay() -> void:
	await get_tree().create_timer(0.2).timeout
	loading.transition()
	await loading.on_transition_finished
	get_tree().change_scene_to_file("res://res/scene/level/demo_level.tscn")
