extends CharacterBody2D

@export var karakter_hizi = 200.0
@export var ziplama_gucu = -400.0
@onready var sprite = $AnimatedSprite2D

func benim_fonksiyonum():
	print(3+5)
	pass

func _ready():
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Yer çekimi ekleme (Yerde değilse aşağı çeker)
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Zıplama kontrolü (W tuşuna basınca ve yerdeyken zıplar)
	if Input.is_action_just_pressed("go_up") and is_on_floor():
		velocity.y = ziplama_gucu

	# Sağa ve Sola Hareket (D ve A tuşları)
	if Input.is_action_pressed("go_right"):
		velocity.x = karakter_hizi
		sprite.flip_h = false
	elif Input.is_action_pressed("go_left"):
		velocity.x = -karakter_hizi
		sprite.flip_h = true
	else:
		velocity.x = 0

	# Hareket durumuna göre animasyon kontrolü
	if velocity.x != 0:
		sprite.play("yurume") # SpriteFrames panelindeki yürüme animasyonunun adı
	else:
		sprite.play("idle")   # Duruş animasyonunun adı

	move_and_slide()
	print(position)
