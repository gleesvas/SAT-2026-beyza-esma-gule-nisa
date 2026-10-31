extends CanvasLayer

@onready var duraklat_paneli: Control = $DuraklatPaneli
@onready var duraklat_butonu: Button = $DuraklatButonu
@onready var devam_et_butonu: Button = $DuraklatPaneli/VBoxContainer/DevamEtButonu
@onready var ana_menu_butonu: Button = $DuraklatPaneli/VBoxContainer/AnaMenuButonu
@onready var cikis_butonu: Button = $DuraklatPaneli/VBoxContainer/CikisButonu

func _ready() -> void:
	# Oyun durdurulduğunda da UI çalışsın
	process_mode = Node.PROCESS_MODE_ALWAYS
	duraklat_paneli.hide()
	
	# Buton tıklamalarını kodla bağla
	duraklat_butonu.pressed.connect(toggle_duraklat)
	devam_et_butonu.pressed.connect(toggle_duraklat)
	ana_menu_butonu.pressed.connect(_on_ana_menu_pressed)
	cikis_butonu.pressed.connect(_on_cikis_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_duraklat()
		get_viewport().set_input_as_handled()

func toggle_duraklat() -> void:
	var yeni_durum = not get_tree().paused
	get_tree().paused = yeni_durum
	duraklat_paneli.visible = yeni_durum

func _on_ana_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/anamenuu.tscn")

func _on_cikis_pressed() -> void:
	get_tree().quit()


func _on_yeniden_basla_butonu_pressed() -> void:
	get_tree().paused = false  # Oyun duraklatılmışsa dondurmayı kaldırır
	get_tree().reload_current_scene()  # O an açık olan haritayı sıfırdan yeniden yükler
