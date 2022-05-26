extends Area2D
class_name Projectile

export(Vector2) var direction
export(int) var damage

func _physics_process(_delta: float) -> void:
	translate(direction)

func on_area_entered(_area) -> void :
	queue_free()

func on_screen_exited():
	queue_free()
