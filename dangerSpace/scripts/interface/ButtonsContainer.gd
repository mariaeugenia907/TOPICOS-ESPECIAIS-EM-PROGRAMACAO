extends Control

signal start_game

func on_Play_pressed() -> void:
	emit_signal("start_game")
	hide()


func on_Quit_pressed() -> void:
	get_tree().quit()
