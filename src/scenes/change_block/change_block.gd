extends StaticBody2D

export(bool) var blocked

func _ready():
	if blocked:
		$Sprite.frame = 1
		set_collsion(0, true)
	else:
		$Sprite.frame = 0
		set_collsion(0, false)
	pass


func change() -> void:
	blocked = not blocked
	if blocked:
		$Sprite.frame = 1
		set_collsion(0, true)
	else:
		$Sprite.frame = 0
		set_collsion(0, false)
	pass


func set_collsion(bit: int, value : bool) -> void:
	set_collision_mask_bit(bit, value)
	set_collision_layer_bit(bit, value)
	pass
