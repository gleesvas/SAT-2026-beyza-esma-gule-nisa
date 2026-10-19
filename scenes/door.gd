extends Area2D

# Geçiş yapmak istediğin sahnenin dosya yolu
@export_file("*.tscn") var target_scene: String

# AnimatedSprite2D düğümünü koda tanıtıyoruz
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	# Oyun başlar başlamaz animasyonu oynatır
	animated_sprite.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if target_scene:
			get_tree().change_scene_to_file(target_scene)
		else:
			print("Hata: Hedef sahne seçilmedi!")
