extends Area2D
class_name Enemy

const EXPLOSION_FX = preload("res://scenes/extras/Explosion.tscn")
const HIT_SFX = preload("res://scenes/extras/Hit_SFX.tscn")

var can_increase_score: bool = false

onready var visibility_notifier: VisibilityNotifier2D = get_node("VisibilityNotifier2D")

export(Vector2) var velocity
export(Vector2) var custom_explosion_scale
export(int) var collision_damage
export(int) var health
export(int) var score

func _ready() -> void:
	var _connect = visibility_notifier.connect("screen_exited", self, "queue_free")
	
func _physics_process(_delta: float) -> void:
	translate(velocity)

func one_area_entered(area):
	if area.is_in_group("player"):
		create_explosion()
		
	if area.is_in_group("projectile"):
		update_health(area.damage)
		
func update_health(damage:int) -> void:
	health -= damage
	hit_sfx()
	if health <= 0:
		can_increase_score = true
		create_explosion()
	
func hit_sfx() -> void:
	var instanced_sfx = HIT_SFX.instance()
	get_tree().root.call_deferred("add_child", instanced_sfx)
	
func create_explosion() -> void:
	var instanced_explosion = EXPLOSION_FX.instance()
	instanced_explosion.scale = custom_explosion_scale
	instanced_explosion.global_position = global_position
	get_tree().root.call_deferred("add_child", instanced_explosion)
	
	if can_increase_score:
		get_tree().call_group("interface", "increase_score", score)
	
	queue_free()

