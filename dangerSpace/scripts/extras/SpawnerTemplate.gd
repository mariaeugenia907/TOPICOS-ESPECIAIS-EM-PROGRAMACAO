extends Position2D

signal kill

onready var timer: Timer = get_node("Timer")

export(Array, PackedScene) var scenes_to_spawn
export(float) var spawn_cooldown

func start_game() -> void:
	timer.set_wait_time(spawn_cooldown)
	timer.start()
	
func spawn() -> void:
	randomize()
	set_spawner_position()
	var random_pick = randi() % scenes_to_spawn.size()
	var choosen_scene = scenes_to_spawn[random_pick].instance()
	choosen_scene.global_position = global_position
	var _connection = connect("kill", choosen_scene, "create_explosion")
	get_tree().root.call_deferred("add_child", choosen_scene)
	timer.start()
	
func set_spawner_position() -> void:
	var random_spawn_position = rand_range(32, 328)
	position = Vector2(random_spawn_position, -30)
	
func game_over() -> void:
	emit_signal("kill")
	timer.stop()


func on_timer_timeout() -> void:
	spawn()
