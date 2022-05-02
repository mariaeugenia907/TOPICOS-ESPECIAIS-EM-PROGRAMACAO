extends Node2D

var vel = 200

func _ready() -> void:
	pass 
	
func _process(delta: float) -> void:
	translate(Vector2(0, -1) * vel * delta)
