extends Position2D

const PROJECTILE = preload("res://scenes/enemies/EnemyProjectile.tscn")

onready var timer: Timer = get_node("Timer")

export(float) var shoot_cooldown

func _ready() -> void:
	timer.set_wait_time(shoot_cooldown)

func on_timer_timeout() -> void:
	var instanced_projectile = PROJECTILE.instance()
	instanced_projectile.global_position = global_position
	get_tree().root.call_deferred("add_child", instanced_projectile)
	timer.start()

func on_screen_entered():
	timer.start()
