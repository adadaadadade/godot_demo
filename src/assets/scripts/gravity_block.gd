extends Area2D


func _ready():
	connect("body_entered", self, "_on_GravityBlcok_body_entered")
	connect("body_exited", self, "_on_GravityBlcok_body_exited")
	pass


func _on_GravityBlcok_body_entered(body : Node):
	if body.is_in_group("player"):
		body.set("gravity", -(ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector")))


func _on_GravityBlcok_body_exited(body):
	if body.is_in_group("player"):
		body.set("gravity", ProjectSettings.get_setting("physics/2d/default_gravity") * ProjectSettings.get_setting("physics/2d/default_gravity_vector"))
