extends AnimatedSprite



func on_animation_finished() -> void:
	queue_free()
