extends Position2D
class_name ShootSpawner

const PROJECTILE = preload("res://scenes/player/Projectile.tscn")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		var instanced_projectile = PROJECTILE.instance()
		instanced_projectile.global_position = global_position
		get_tree().root.call_deferred("add_child", instanced_projectile)
