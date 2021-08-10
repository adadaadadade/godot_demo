extends Area2D


func _ready():
	pass



func _on_DamageBlcok_body_entered(body : Node):
	if body.is_in_group("player"):
		body.call("die")


func _on_DamageBlcok_body_exited(body : Node):
	pass
