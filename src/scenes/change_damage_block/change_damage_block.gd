extends Area2D

export(bool) var blocked

func _ready():
	if blocked:
		$Sprite.frame = 1
		set_collsion(0, true)
	else:
		$Sprite.frame = 0
		set_collsion(0, false)


func change() -> void:
	blocked = not blocked
	if blocked:
		$Sprite.frame = 1
		set_collsion(0, true)
	else:
		$Sprite.frame = 0
		set_collsion(0, false)


func set_collsion(bit: int, value : bool) -> void:
	set_collision_mask_bit(bit, value)
	set_collision_layer_bit(bit, value)


func _on_ChangeDamageBlock_body_entered(body):
	if body.is_in_group("player"):
		body.call("die")


func _on_ChangeDamageBlock_body_exited(body):
	pass # Replace with function body.
