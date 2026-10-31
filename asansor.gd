extends AnimatableBody2D

@export var move_offset: Vector2 = Vector2(0, -160) # -160 piksel yukarı
@export var move_duration: float = 2.0

var start_position: Vector2
var target_position: Vector2
var current_tween: Tween

func _ready() -> void:
	start_position = global_position
	target_position = start_position + move_offset

func toggle(is_active: bool) -> void:
	print("Asansör komut aldı! Aktif mi: ", is_active)
	var destination := target_position if is_active else start_position
	
	if current_tween and current_tween.is_running():
		current_tween.kill()
		
	current_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	current_tween.tween_property(self, "global_position", destination, move_duration)
