extends AnimatedSprite

func _ready() -> void:
	play("Idle")

func on_animation_finished() -> void:
	queue_free()
