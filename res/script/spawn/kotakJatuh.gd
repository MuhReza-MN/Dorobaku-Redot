class_name KotakJatuh extends CharacterBody2D

var input_movement = Vector2.ZERO
var speed = 100

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var kotak: CollisionShape2D = $CollisionShape2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var huruf: Sprite2D = $Sprite2D
@export var nama_kotak: String = "some_name_here"
@export var can_move: bool = true

func _ready() -> void:
	can_move = true
	kotak.disabled = false
	$".".set_collision_layer_value(1, true)
	$".".set_collision_layer_value(5, true)

func set_block(huruf):
	anim.play(huruf)

func jatuh():
	can_move = false
	kotak.disabled = true
	$".".set_collision_layer_value(1, false)
	$".".set_collision_layer_value(5, false)
