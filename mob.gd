extends RigidBody2D

func _ready() -> void:
	var anims: Array = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	var anim: String = anims.pick_random();
	$AnimatedSprite2D.play(anim)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
