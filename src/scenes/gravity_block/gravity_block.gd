extends Area2D


func _ready():
	$AnimationPlayer.play("play")
	pass


func _on_GravityBlcok_body_entered(body : Node):
	if body.is_in_group("player"):
		body.set("gravity", self.gravity * self.gravity_vec)
	pass # Replace with function body.


func _on_GravityBlcok_body_exited(body):
	if body.is_in_group("player"):
		body.set("gravity", ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector"))
