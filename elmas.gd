extends Area2D

## Süzülme Ayarları
@export var suzulme_mesafesi: float = 5.0  # Yukarı-aşağı kaç piksel oynayacağı
@export var suzulme_suresi: float = 0.8     # Bir yön hareketi kaç saniye sürecek

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	# Elmas sahneye yüklenince kendini gruba ekler
	add_to_group("elmaslar")
	body_entered.connect(_on_body_entered)
	
	# Yukarı-aşağı süzülme animasyonunu başlat
	_suzülme_animasyonu_baslat()


func _suzülme_animasyonu_baslat() -> void:
	if not sprite:
		return
		
	var baslangic_y := sprite.position.y
	
	# Sonsuz döngüde yumuşak (Sine) hareket oluşturan Tween
	var tween := create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# Önce hafifçe yukarı çıksın
	tween.tween_property(sprite, "position:y", baslangic_y - suzulme_mesafesi, suzulme_suresi)
	# Sonra başlangıç konumunun biraz altına insin
	tween.tween_property(sprite, "position:y", baslangic_y + suzulme_mesafesi, suzulme_suresi)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		remove_from_group("elmaslar")
		queue_free()
