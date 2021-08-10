extends Area2D
export(String) var scene_path

const SIMULATED_DELAY_SEC = 0.1

var load_thread : Thread
var packed_scene : PackedScene

func _ready():
	pass


func _on_SceneChangeBlock_body_entered(body : Node):
	if body.is_in_group("player"):
		get_tree().change_scene(scene_path)
