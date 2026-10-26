extends Button # Eğer TextureButton kullandıysan burayı 'extends TextureButton' yap

func _ready() -> void:
	pivot_offset = size / 2
	# Sinyalleri doğrudan bu script'e bağlıyoruz:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

# Fare üzerine gelince %15 büyüt
func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.15, 1.15), 0.1).set_trans(Tween.TRANS_SINE)

# Fare ayrılınca normal boyutuna döndür
func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_SINE)

# Tıklandığında anlık küçülme ve bırakınca açılma tepkisi
func _on_button_down() -> void:
	scale = Vector2(0.95, 0.95)

func _on_button_up() -> void:
	scale = Vector2(1.15, 1.15)
