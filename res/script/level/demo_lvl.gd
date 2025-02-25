class_name DemoLevel extends Node

var game_end : bool = false
var info : bool = false
@onready var label: Label = $ui_layer/Panel/Label
@onready var timer: Timer = $Timer
@onready var musicLvl = preload("res://res/asset/sound/bgm3.mp3")

var h1 = "i"
var h2 = "z"
var h3 = "n"
var h4 = "j"
var box = "kosong"
var maxTime = 201.0
var timeLeft
var lobang = true
var lobang2 = true

@onready var target = $cek_grup.get_child_count()
var cocok = target

func _ready() -> void:
	AudioPlayer._play_lvl_music(musicLvl)
	$ui_layer/papan.visible = false
	timer.wait_time = maxTime
	for i in $kotak_grup.get_children() :
		i.add_to_group(i.nama_kotak)
	box_setup()
	timer.start()
				
func box_setup() -> void:
	get_tree().get_nodes_in_group("i")[0].set_block(h1)
	get_tree().get_nodes_in_group("z")[0].set_block(h2)
	get_tree().get_nodes_in_group("i")[1].set_block(h1)
	get_tree().get_nodes_in_group("n")[0].set_block(h3)
	get_tree().get_nodes_in_group("j")[0].set_block(h4)
	get_tree().get_nodes_in_group("kosong")[0].set_block(box)
	get_tree().get_nodes_in_group("kosong")[1].set_block(box)

func _process(delta: float) -> void:
	if game_end == false :
		label.text = str(int(timer.time_left))
		if target == 0 :
			$dinding.visible = false
			$dinding/CollisionShape2D.disabled = true
			timer.paused = true
			timeLeft = int(timer.time_left)
			timer.stop()
			label.text = str(timeLeft)
			game_end = true
		elif timer.time_left == 0.0 :
			game_end = true
			selesai()
		
func _on_touch_screen_button_pressed() -> void:
	restart()
func restart():
	game_end = false
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _send_cek(nama_box,nama_cek) -> void:
	if nama_box == nama_cek :
		target -= 1
		print("cek sisa " + str(target))

func _exit_cek() -> void:
	if target == cocok :
		pass
	else :
		target += 1
		print("exit balik " + str(target))

func _kotak_jatuh( b: Node2D) -> void:
	if b is KotakHuruf :
		if lobang :
			b.jatuh()
			$Area2D/CollisionShape2D.disabled = true
			$lobang.set_collision_layer_value(5,false)
			await get_tree().create_timer(0.2).timeout
			lobang = false
			
func _kotak_jatuh2( b: Node2D) -> void:
	if b is KotakHuruf :
		if lobang2 :
			b.jatuh()
			$Area2D2/CollisionShape2D.disabled = true
			$lobang2.set_collision_layer_value(5,false)
			await get_tree().create_timer(0.2).timeout
			lobang2 = false

func _finish(body: Node2D) -> void:
	if body is Player :
		selesai()

func selesai():
	$ui_layer/movement_btn.visible = false
	$ui_layer/reset.visible = false
	$Player.visible = false
	$ui_layer/papan.visible = true
