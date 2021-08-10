extends StaticBody2D

export(float) var disappear_time
export(float) var resume_time

var disappearing : bool = false

func _ready():
	pass


func disappear():
	if disappearing:
		return
	$AnimationPlayer.play("disappear")
	$DisappearTimer.start(disappear_time)
	disappearing = true
	pass

func _on_ResumeTimer_timeout():
	$Sprite.show()
	set_collision_layer_bit(0, true)
	set_collision_mask_bit(0, true)
	$ResumeTimer.stop()
	disappearing = false
	pass # Replace with function body.


func _on_DisappearTimer_timeout():
	$Sprite.hide()
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(0, false)
	$AnimationPlayer.stop()
	$ResumeTimer.start(resume_time)
	$DisappearTimer.stop()
	pass # Replace with function body.
