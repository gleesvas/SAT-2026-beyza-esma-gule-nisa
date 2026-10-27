extends CharacterBody2D
## Light (player_id = 1) ve Shadow (player_id = 2) için ortak platform oyuncusu.

@export_range(1, 2) var player_id: int = 1
@export var speed: float = 170.0
@export var jump_velocity: float = -300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var spawn_position: Vector2


func _ready() -> void:
	add_to_group("players")
	spawn_position = global_position


func _physics_process(delta: float) -> void:
	# Yerçekimi
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Tuş Kontrolleri (Player 1: Ok Tuşları | Player 2: WASD)
	var left_pressed := false
	var right_pressed := false
	var jump_pressed := false

	if player_id == 1:
		left_pressed = Input.is_action_pressed("p1_left") or Input.is_key_pressed(KEY_LEFT)
		right_pressed = Input.is_action_pressed("p1_right") or Input.is_key_pressed(KEY_RIGHT)
		jump_pressed = Input.is_action_just_pressed("p1_jump") or Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_SPACE)
	else:
		left_pressed = Input.is_action_pressed("p2_left") or Input.is_key_pressed(KEY_A)
		right_pressed = Input.is_action_pressed("p2_right") or Input.is_key_pressed(KEY_D)
		jump_pressed = Input.is_action_just_pressed("p2_jump") or Input.is_key_pressed(KEY_W)

	# Zıplama Kontrolü
	if jump_pressed and is_on_floor():
		velocity.y = jump_velocity

	# Yön ve Hareket
	var direction := 0.0
	if left_pressed:
		direction -= 1.0
	if right_pressed:
		direction += 1.0

	if direction != 0.0:
		velocity.x = direction * speed
		sprite.flip_h = (direction < 0.0)
		_play_anim("yurume")
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		_play_anim("idle")

	move_and_slide()

	# Düşme kontrolü
	if global_position.y > 1200.0:
		respawn()


## Başlangıç noktasını belirler.
func set_spawn(pos: Vector2) -> void:
	spawn_position = pos
	global_position = pos


## Karakteri başlangıç noktasına döndürür.
func respawn() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO
	sprite.flip_h = false
	_play_anim("idle")
	sprite.modulate = Color(1.0, 0.35, 0.35)
	var tween := create_tween()
	tween.tween_property(sprite, "modulate", Color.WHITE, 0.4)


## Animasyonu güvenli şekilde oynatır.
func _play_anim(anim_name: StringName) -> void:
	if sprite == null or sprite.sprite_frames == null:
		return
	if not sprite.sprite_frames.has_animation(anim_name):
		return
	if sprite.animation != anim_name or not sprite.is_playing():
		sprite.play(anim_name)
