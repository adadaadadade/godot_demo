extends Node2D


func _ready():
	
	pass


func _on_CheckPoint_body_entered(body : Node):
	if body.is_in_group("player"):
		get_parent().set_current_check_point(self)
	pass # Replace with function body.


func remove_current() -> void:
	$Sprite.frame = 0


func set_current() -> void:
	$Sprite.frame = 1
