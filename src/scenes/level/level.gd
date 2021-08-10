class_name level
extends Node2D

var change_blocks_array : Array = []

var PlayerScene : PackedScene = preload("res://scenes/player/player.tscn")


onready var current_player = $Player
onready var current_check_point = $CheckPoint

func _ready():
	for node in get_children():
		if node.is_in_group("change_block"):
			change_blocks_array.append(node)
	


func _physics_process(delta):
	pass
	


func change_blocks():
	for node in change_blocks_array:
		node.change()
	


func respawn_player() -> void:
	current_player.queue_free()
	current_player = null
	var new_player = PlayerScene.instance()
	self.add_child(new_player)
	new_player.position = current_check_point.position
	current_player = new_player
	#print_tree_pretty()
	
	


func set_current_check_point(new_check_point) -> void:
	current_check_point.remove_current()
	new_check_point.set_current()
	current_check_point = new_check_point
