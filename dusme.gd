extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Yalnızca karakterler girince bölüm yeniden başlar
	# Kutular (RigidBody2D) girdiğinde oyun devam eder ve köprü olur
	if body is CharacterBody2D:
		get_tree().reload_current_scene()
