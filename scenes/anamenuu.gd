extends Control

# Ana Menü Elemanları
@onready var ana_butonlar: VBoxContainer = $VBoxContainer
@onready var oynabuton: Button = $VBoxContainer/oynabuton
@onready var ayarlarbuton: Button = $VBoxContainer/ayarlarbuton
@onready var bolumler_butonu: Button = $VBoxContainer/bolumler
@onready var cikisbuton: Button = $VBoxContainer/cikisbuton

# Paneller
@onready var ayarlar_paneli: Panel = $AyarlarPaneli
@onready var bolumler_paneli: Panel = $BolumlerPaneli

# Ayarlar Paneli Elemanları
@onready var ayarlar_kapat: Button = $AyarlarPaneli/kapatButonu

# Bölümler Paneli Elemanları
@onready var bolumler_kapat: Button = $BolumlerPaneli/KapatButonu
@onready var bolum1_butonu: Button = $BolumlerPaneli/HBoxContainer/Bolum1
@onready var bolum2_butonu: Button = $BolumlerPaneli/HBoxContainer/Bolum2
@onready var bolum3_butonu: Button = $BolumlerPaneli/HBoxContainer/Bolum3


func _ready() -> void:
	# Başlangıçta panelleri gizle, ana menü butonlarını göster
	if ayarlar_paneli:
		ayarlar_paneli.hide()
	if bolumler_paneli:
		bolumler_paneli.hide()
	if ana_butonlar:
		ana_butonlar.show()

	# Ana Menü Buton Bağlantıları
	if oynabuton and not oynabuton.pressed.is_connected(_on_oyna_pressed):
		oynabuton.pressed.connect(_on_oyna_pressed)
	if ayarlarbuton and not ayarlarbuton.pressed.is_connected(_on_ayarlar_pressed):
		ayarlarbuton.pressed.connect(_on_ayarlar_pressed)
	if bolumler_butonu and not bolumler_butonu.pressed.is_connected(_on_bolumler_pressed):
		bolumler_butonu.pressed.connect(_on_bolumler_pressed)
	if cikisbuton and not cikisbuton.pressed.is_connected(_on_cikis_pressed):
		cikisbuton.pressed.connect(_on_cikis_pressed)

	# Panel Kapatma Buton Bağlantıları
	if ayarlar_kapat and not ayarlar_kapat.pressed.is_connected(_on_ayarlar_kapat_pressed):
		ayarlar_kapat.pressed.connect(_on_ayarlar_kapat_pressed)
	if bolumler_kapat and not bolumler_kapat.pressed.is_connected(_on_kapat_butonu_pressed):
		bolumler_kapat.pressed.connect(_on_kapat_butonu_pressed)


# --- ANA MENÜ BUTONLARI ---

func _on_oyna_pressed() -> void:
	_harita_ac("res://scenes/harita1.tscn")


func _on_bolumler_pressed() -> void:
	if bolumler_paneli:
		bolumler_paneli.show()
	if ayarlar_paneli:
		ayarlar_paneli.hide()
	if ana_butonlar:
		ana_butonlar.hide() # Panelle çakışmaması için arka plandaki butonları gizler


func _on_ayarlar_pressed() -> void:
	if ayarlar_paneli:
		ayarlar_paneli.show()
	if bolumler_paneli:
		bolumler_paneli.hide()
	if ana_butonlar:
		ana_butonlar.hide() # Panelle çakışmaması için arka plandaki butonları gizler


func _on_cikis_pressed() -> void:
	get_tree().quit()


# --- PANEL KAPATMA BUTONLARI ---

func _on_ayarlar_kapat_pressed() -> void:
	if ayarlar_paneli:
		ayarlar_paneli.hide()
	if ana_butonlar:
		ana_butonlar.show() # Ana menü butonlarını geri getirir


func _on_kapat_butonu_pressed() -> void:
	if bolumler_paneli:
		bolumler_paneli.hide()
	if ana_butonlar:
		ana_butonlar.show() # Ana menü butonlarını geri getirir


# --- BÖLÜM SEÇİM BUTONLARI ---

func _on_bolum_1_pressed() -> void:
	_harita_ac("res://scenes/harita1.tscn")


func _on_bolum_2_pressed() -> void:
	_harita_ac("res://scenes/harita2.tscn")


func _on_bolum_3_pressed() -> void:
	_harita_ac("res://scenes/harita3.tscn")


# --- GENEL SAHNE YÜKLEME ---

func _harita_ac(harita_yolu: String) -> void:
	get_tree().change_scene_to_file(harita_yolu)
