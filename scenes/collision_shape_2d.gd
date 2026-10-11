extends CharacterBody2D

@export var karakter_hizi = 500.0

func benim_fonksiyonum():
	print(3+5)
	pass

func _ready():
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, 0)
	# Sağa ve Sola Hareket (D ve A tuşları)
	if Input.is_action_pressed("go_right"):
		velocity.x = karakter_hizi
	elif Input.is_action_pressed("go_left"):
		velocity.x = -karakter_hizi
	else:
		velocity.x = 0

	# Yukarı ve Aşağı Hareket (W ve S tuşları)
	if Input.is_action_pressed("go_down"):
		velocity.y = karakter_hizi
	elif Input.is_action_pressed("go_up"):
		velocity.y = -karakter_hizi
	else:
		velocity.y = 0

	move_and_slide()
	print(position)
