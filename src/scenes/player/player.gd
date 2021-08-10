extends KinematicBody2D

export(float) var move_speed
export(float) var jump_start_speed
export(float) var wall_gravity_weight
export(float) var jump_times
export(float) var move_speed_change_per_frame

const jump_stop = 0.6

var move_vector : Vector2 = Vector2.ZERO
var jump : bool = false
var jump_released : bool = false
var change : bool = false
var respawn : bool = false

var linear_velocity : Vector2 = Vector2.ZERO
var vertical_velocity : Vector2 = Vector2.ZERO

var can_jump : int = 0
var double_jumped : bool = false

onready var gravity : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")
onready var platform_detector : RayCast2D = get_node("PlatformDetector")
onready var wall_detector_left : RayCast2D = get_node("WallDetectorLeft")
onready var wall_detector_right : RayCast2D = get_node("WallDetectorRight") 
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")
onready var sprite : Sprite = get_node("Sprite")
onready var audio_stream_player = get_node("AudioStreamPlayer2D")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	handle_input()
	linear_velocity += gravity * delta
	
	if move_vector.x != 0:
		if move_vector.x > 0:
			sprite.scale.x = abs(sprite.scale.x)
		else:
			sprite.scale.x = -abs(sprite.scale.x)
	
	if move_vector.x != 0:
		linear_velocity.x += move_vector.x * move_speed_change_per_frame
		linear_velocity.x = clamp(linear_velocity.x, -move_speed, move_speed)
	else:
		if abs(linear_velocity.x) > move_speed_change_per_frame:
			linear_velocity.x -= move_speed_change_per_frame if linear_velocity.x > 0 else -move_speed_change_per_frame
		else:
			linear_velocity.x = 0
	
	if jump and can_jump > 0:
		audio_stream_player.play()
		linear_velocity.y = -jump_start_speed
		jump = false
		can_jump -= 1
	
	if jump_released and linear_velocity.y < 0:
		linear_velocity.y *= jump_stop
		jump_released = false
	
	var new_animation = get_new_animation()
	if animation_player.current_animation != new_animation:
		animation_player.play(new_animation)
	
	linear_velocity = move_and_slide(linear_velocity, Vector2.UP, true, 4)
	# 靠墙，速度向下
	if wall_detector_left.is_colliding() or wall_detector_right.is_colliding():
		if linear_velocity.y > 0:
			linear_velocity -= gravity * wall_gravity_weight * delta
		can_jump = jump_times
	# bug 因为离开速度慢，所以跳起后这一帧还会探测到。。。
	if is_on_floor():
		can_jump = jump_times
	
	if is_on_ceiling():
		linear_velocity.y = 0
	
	
	
	if change:
		get_parent().call("change_blocks")
	
	pass

func _process(delta):
	if respawn:
		die()
	detect_disppear_blocks()
	pass

func detect_disppear_blocks() -> void:
	#if platform_detector.is_colliding():
	if platform_detector.get_collider() and platform_detector.get_collider().has_method("disappear"):
		platform_detector.get_collider().disappear()
	if wall_detector_left.get_collider() and wall_detector_left.get_collider().has_method("disappear"):
		wall_detector_left.get_collider().disappear()
	if wall_detector_right.get_collider() and wall_detector_right.get_collider().has_method("disappear"):
		wall_detector_right.get_collider().disappear()
	pass


func handle_input() -> void:
	move_vector = handle_move_vector()
	jump = Input.is_action_just_pressed("player_jump")
	jump_released = Input.is_action_just_released("player_jump")
	change = Input.is_action_just_pressed("player_change")
	respawn = Input.is_action_just_pressed("player_respawn")
	pass

func handle_move_vector() -> Vector2:
	var vector = Vector2.ZERO
	vector.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	return vector


func die() -> void:
	get_parent().call("respawn_player")


func get_new_animation():
	var animation_new = ""
	if is_on_floor():
		if abs(linear_velocity.x) > 0.1:
			animation_new = "run"
		else:
			animation_new = "stand"
	else:
		if linear_velocity.y > 0:
			animation_new = "falling"
		else:
			animation_new = "jumping"
	return animation_new

