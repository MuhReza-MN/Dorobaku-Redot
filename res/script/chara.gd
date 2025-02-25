class_name Player extends CharacterBody2D

@onready var anim_tree: AnimationTree = $anim_tree
@onready var anim_state = anim_tree.get("parameters/playback")
@onready var cast: ShapeCast2D = $ShapeCast2D
@onready var fx_walk = preload("res://res/asset/sound/sfx2/walk.mp3")
@onready var fx_push = preload("res://res/asset/sound/sfx2/push.mp3")

var speed = 200
var can_move = true
var is_moving = false

func _physics_process( delta ):
	if can_move : 
		move()

func move():
	var input_movement = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		input_movement.y -= 1
	elif Input.is_action_pressed("down"):
		input_movement.y += 1
	elif Input.is_action_pressed("right"):
		input_movement.x += 1
	elif Input.is_action_pressed("left"):
		input_movement.x -= 1
	
	if input_movement != Vector2.ZERO:
		anim_tree.set("parameters/idle/blend_position", input_movement)
		anim_tree.set("parameters/walk/blend_position", input_movement)
		anim_state.travel("walk")
		velocity = input_movement * speed
	
	if input_movement == Vector2.ZERO:
		anim_state.travel("idle")
		velocity = Vector2.ZERO
		
	await get_tree().create_timer(0.01).timeout
	cast.force_shapecast_update()
	if cast.is_colliding():
		var collider = cast.get_collider(0)
		if collider is KotakHuruf :
			if collider.move(input_movement):
				move_and_slide()
				return
	
	move_and_slide()
