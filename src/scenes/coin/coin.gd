extends Area2D


func _ready():
	pass


func _on_Coin_body_entered(body : Node):
	if body.is_in_group("player"):
		_player_get_coin()


func _player_get_coin():
	$AnimationPlayer.play("picked")
