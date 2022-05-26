extends CanvasLayer

var score: int

onready var label_score: Label = get_node("Score Container/Label")
onready var buttons_container: Control = get_node("ButtonsContainer")
onready var final_score: Label = get_node("FinalScore")
onready var health_hud: Sprite = get_node("HealthHud")

func increase_score(value: int) -> void:
	score += value
	label_score.text = str(score)

func update_hud(value: int, type: String) -> void:
	match type:
		"Heal":
			health_hud.frame = value
		"Hurt":
			health_hud.frame = value

func game_over() -> void:
	final_score.text = "Pontuação Final: " + str(score)
	buttons_container.show()
	final_score.show()
	
func reset() -> void:
	score = 0
	health_hud.frame = 4
	label_score.text = str(score)
	final_score.hide()
	
	
	
	
	
	
	
	
	
	
	
