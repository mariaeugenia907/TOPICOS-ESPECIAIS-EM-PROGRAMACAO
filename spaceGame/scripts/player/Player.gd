extends Area2D
class_name Player

onready var animation_tree: AnimationTree = get_node("AnimationTree")
#onready var x_screen_size: int = get_viewport().get_visible_rect().size.x

export(Vector2) var velocity
export(float) var speed

func _physics_process(_delta: float) -> void:
	move()
	verify_position()

func move() -> void:
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	animation_tree.set("parameters/blend_position", velocity.x)
	translate(velocity * speed)

func verify_position() -> void:
	#var x_form = get_transform()
	#if x_form.origin.x > x_screen_size:
	#	x_form.origin.x = 0
	#if x_form.origin.x < 0:
	#	x_form.origin = x_screen_size
	#set_transform(x_form)
	global_position.x = clamp(global_position.x, 5, 355)
