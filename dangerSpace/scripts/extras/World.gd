extends Node

const PLAYER = preload("res://scenes/player/Player.tscn")

onready var interface: CanvasLayer = get_node("Interface")
onready var enemies_spawner: Position2D = get_node("EnemySpawner")

export(Vector2) var custom_initial_position

func start_game() -> void:
	interface.reset()
	var instanced_player = PLAYER.instance()
	instanced_player.position = custom_initial_position
	instanced_player.connect("game_over", interface, "game_over")
	instanced_player.connect("game_over", enemies_spawner, "game_over")
	get_tree().root.call_deferred("add_child", instanced_player)






