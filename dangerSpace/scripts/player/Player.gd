extends Area2D
class_name Player

signal game_over

const EXPLOSION_FX = preload("res://scenes/extras/Explosion.tscn")
const HIT_SFX = preload("res://scenes/extras/Hit_SFX.tscn")

onready var animation_tree: AnimationTree = get_node("AnimationTree")
#onready var x_screen_size: int = get_viewport().get_visible_rect().size.x

export(Vector2) var velocity
export(Vector2) var custom_explosion_scale
export(float) var speed
export(int) var health

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


func on_area_entered(area: Area2D) -> void:
	if area.is_in_group("projectile"):
		update_health(area.damage, "Hurt")
	else: 
		update_health(area.collision_damage, "Hurt")

func update_health(damage: int, type: String) -> void:
	match type:
		"Hurt":
			if health > 0:
				hit_sfx()
				health -= damage
				
	get_tree().call_group("interface", "update_hud", health, type)
	
	if health <= 0:
		create_explosion()

func hit_sfx() -> void:
	var instanced_sfx = HIT_SFX.instance()
	get_tree().root.call_deferred("add_child", instanced_sfx)
	
func create_explosion() -> void:
	var instanced_explosion = EXPLOSION_FX.instance()
	instanced_explosion.global_position = global_position
	instanced_explosion.scale = custom_explosion_scale
	get_tree().root.call_deferred("add_child", instanced_explosion)
	kill()

func kill() -> void:
	emit_signal("game_over")
	queue_free()
