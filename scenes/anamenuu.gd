extends Control

# Ana Menü Elemanları
@onready var ana_butonlar: VBoxContainer = $VBoxContainer
@onready var oynabuton: Button = $VBoxContainer/oynabuton
@onready var ayarlarbuton: Button = $VBoxContainer/ayarlarbuton
@onready var bolumler_butonu: Button = $VBoxContainer/bolumler
@onready var nasiloynanirbuton: Button = $VBoxContainer/nasiloynanirbuton
@onready var cikisbuton: Button = $VBoxContainer/cikisbuton

# Başlık Görseli
@onready var giris_baslik: Sprite2D = $Girisbaslik

# Paneller
@onready var ayarlar_paneli: Panel = $AyarlarPaneli
@onready var bolumler_paneli: Panel = $BolumlerPaneli
@onready var nasil_oynanir_paneli: Panel = $NasilOynanirPaneli

# Ayarlar Paneli Elemanları
@onready var ayarlar_kapat: Button = $AyarlarPaneli/kapatButonu

# Bölümler Paneli Elemanları
@onready var bolumler_kapat: Button = $BolumlerPaneli/KapatButonu
@onready var bolum1_butonu: Button = $BolumlerPaneli/HBoxContainer/Bolum1
@onready var bolum2_butonu: Button = $BolumlerPaneli/HBoxContainer/Bolum2
@onready var bolum3_butonu: Button = $BolumlerPaneli/HBoxContainer/Bolum3

# Nasıl Oynanır Paneli Elemanları
@onready var baslik_label: Label = $NasilOynanirPaneli/VBoxContainer/BaslikLabel
@onready var gorsel: TextureRect = $NasilOynanirPaneli/VBoxContainer/Gorsel
@onready var aciklama_label: Label = $NasilOynanirPaneli/VBoxContainer/AciklamaLabel
@onready var sayfa_label: Label = $NasilOynanirPaneli/VBoxContainer/HBoxContainer/SayfaLabel
@onready var geri_butonu: Button = $NasilOynanirPaneli/VBoxContainer/HBoxContainer/GeriButonu
@onready var ileri_butonu: Button = $NasilOynanirPaneli/VBoxContainer/HBoxContainer/IleriButonu
@onready var nasil_oynanir_kapat: Button = $NasilOynanirPaneli/VBoxContainer/KapatButonu

# Özel İmleç Kaplamaları
var imlec_tex_normal: ImageTexture
var imlec_tex_tiklama: ImageTexture

# Öğretici Sayfaları Verisi
var mevcut_sayfa: int = 0
var sayfalar: Array = [
	{
		"baslik": "HİKAYE",
		"gorsel": preload("res://shadowandlight.jpeg"),
		"yazi": "Karanlık ve ışığın dengesini korumak için iki kahramanımızın zorlu macerası başlıyor..."
	},
	{
		"baslik": "KONTROLLER",
		"gorsel": preload("res://yontuslari.jpeg"),
		"yazi": "Shadow: W-A-S-D tuşları ile hareket eder.\nLight: Yön (Ok) tuşları ile hareket eder."
	},
	{
		"baslik": "GÖREVLER VE PORTAL",
		"gorsel": preload("res://elmastoplama.jpeg"),
		"yazi": "Haritadaki tüm mor elmasları toplayın! Tüm elmaslar toplanmadan portal aktif olmaz."
	}
]


func _ready() -> void:
	# İmleç sistemini başlat
	_imlec_sistemini_kur()

	# Başlangıçta panelleri gizle, ana menü butonlarını göster
	if ayarlar_paneli:
		ayarlar_paneli.hide()
	if bolumler_paneli:
		bolumler_paneli.hide()
	if nasil_oynanir_paneli:
		nasil_oynanir_paneli.hide()
	if ana_butonlar:
		ana_butonlar.show()

	# Logo süzülme animasyonunu başlat
	_baslik_animasyonu_baslat()

	# Ana Menü Buton Bağlantıları
	if oynabuton and not oynabuton.pressed.is_connected(_on_oyna_pressed):
		oynabuton.pressed.connect(_on_oyna_pressed)
	if ayarlarbuton and not ayarlarbuton.pressed.is_connected(_on_ayarlar_pressed):
		ayarlarbuton.pressed.connect(_on_ayarlar_pressed)
	if bolumler_butonu and not bolumler_butonu.pressed.is_connected(_on_bolumler_pressed):
		bolumler_butonu.pressed.connect(_on_bolumler_pressed)
	if nasiloynanirbuton and not nasiloynanirbuton.pressed.is_connected(_on_nasil_oynanir_pressed):
		nasiloynanirbuton.pressed.connect(_on_nasil_oynanir_pressed)
	if cikisbuton and not cikisbuton.pressed.is_connected(_on_cikis_pressed):
		cikisbuton.pressed.connect(_on_cikis_pressed)

	# Bölüm Seçim Buton Bağlantıları
	if bolum1_butonu and not bolum1_butonu.pressed.is_connected(_on_bolum_1_pressed):
		bolum1_butonu.pressed.connect(_on_bolum_1_pressed)
	if bolum2_butonu and not bolum2_butonu.pressed.is_connected(_on_bolum_2_pressed):
		bolum2_butonu.pressed.connect(_on_bolum_2_pressed)
	if bolum3_butonu and not bolum3_butonu.pressed.is_connected(_on_bolum_3_pressed):
		bolum3_butonu.pressed.connect(_on_bolum_3_pressed)

	# Panel Kapatma Buton Bağlantıları
	if ayarlar_kapat and not ayarlar_kapat.pressed.is_connected(_on_ayarlar_kapat_pressed):
		ayarlar_kapat.pressed.connect(_on_ayarlar_kapat_pressed)
	if bolumler_kapat and not bolumler_kapat.pressed.is_connected(_on_kapat_butonu_pressed):
		bolumler_kapat.pressed.connect(_on_kapat_butonu_pressed)
	if nasil_oynanir_kapat and not nasil_oynanir_kapat.pressed.is_connected(_on_nasil_oynanir_kapat_pressed):
		nasil_oynanir_kapat.pressed.connect(_on_nasil_oynanir_kapat_pressed)

	# Sayfa Değiştirme Buton Bağlantıları
	if geri_butonu and not geri_butonu.pressed.is_connected(_on_geri_pressed):
		geri_butonu.pressed.connect(_on_geri_pressed)
	if ileri_butonu and not ileri_butonu.pressed.is_connected(_on_ileri_pressed):
		ileri_butonu.pressed.connect(_on_ileri_pressed)


# --- ÖZEL İMLEÇ VE TIKLAMA YÖNETİMİ ---

func _imlec_sistemini_kur() -> void:
	# UYARI: "res://imlec.png" yolunu kendi imleç dosyanızın ismiyle değiştirin.
	var imlec_yolu := "res://imlec.png"
	
	if ResourceLoader.exists(imlec_yolu):
		var orijinal_img: Image = load(imlec_yolu).get_image()
		
		# Normal boyut (Örn: 64x64 piksel)
		var normal_genislik := 64
		var normal_yukseklik := 64
		var img_normal := orijinal_img.duplicate() as Image
		img_normal.resize(normal_genislik, normal_yukseklik, Image.INTERPOLATE_NEAREST)
		imlec_tex_normal = ImageTexture.create_from_image(img_normal)
		
		# Tıklama anı için küçültülmüş boyut (%80 boyutu)
		var kucuk_genislik := int(normal_genislik * 0.80)
		var kucuk_yukseklik := int(normal_yukseklik * 0.80)
		var img_tiklama := orijinal_img.duplicate() as Image
		img_tiklama.resize(kucuk_genislik, kucuk_yukseklik, Image.INTERPOLATE_NEAREST)
		imlec_tex_tiklama = ImageTexture.create_from_image(img_tiklama)
		
		# İlk durum olarak normal imleci atayalım
		Input.set_custom_mouse_cursor(imlec_tex_normal, Input.CURSOR_ARROW, Vector2(0, 0))


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if imlec_tex_tiklama:
				Input.set_custom_mouse_cursor(imlec_tex_tiklama, Input.CURSOR_ARROW, Vector2(0, 0))
		else:
			if imlec_tex_normal:
				Input.set_custom_mouse_cursor(imlec_tex_normal, Input.CURSOR_ARROW, Vector2(0, 0))


# --- LOGO ANİMASYONU ---

func _baslik_animasyonu_baslat() -> void:
	if not giris_baslik:
		return
		
	var baslangic_y := giris_baslik.position.y
	
	# Sonsuz döngüde yumuşak (Sine) süzülme hareketi
	var tween := create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# 1.5 saniyede 10 piksel yukarı, 1.5 saniyede 10 piksel aşağı hareket eder
	tween.tween_property(giris_baslik, "position:y", baslangic_y - 10.0, 1.5)
	tween.tween_property(giris_baslik, "position:y", baslangic_y + 10.0, 1.5)


# --- ANA MENÜ BUTONLARI ---

func _on_oyna_pressed() -> void:
	_harita_ac("res://scenes/harita1.tscn")


func _on_bolumler_pressed() -> void:
	_panelleri_yonet(bolumler_paneli)


func _on_ayarlar_pressed() -> void:
	_panelleri_yonet(ayarlar_paneli)


func _on_nasil_oynanir_pressed() -> void:
	mevcut_sayfa = 0
	_sayfayi_guncelle()
	_panelleri_yonet(nasil_oynanir_paneli)


func _on_cikis_pressed() -> void:
	get_tree().quit()


# --- PANEL KAPATMA BUTONLARI ---

func _on_ayarlar_kapat_pressed() -> void:
	if ayarlar_paneli:
		ayarlar_paneli.hide()
	if ana_butonlar:
		ana_butonlar.show()


func _on_kapat_butonu_pressed() -> void:
	if bolumler_paneli:
		bolumler_paneli.hide()
	if ana_butonlar:
		ana_butonlar.show()


func _on_nasil_oynanir_kapat_pressed() -> void:
	if nasil_oynanir_paneli:
		nasil_oynanir_paneli.hide()
	if ana_butonlar:
		ana_butonlar.show()


# --- ÖĞRETİCİ SAYFA YÖNETİMİ ---

func _on_ileri_pressed() -> void:
	if mevcut_sayfa < sayfalar.size() - 1:
		mevcut_sayfa += 1
		_sayfayi_guncelle()


func _on_geri_pressed() -> void:
	if mevcut_sayfa > 0:
		mevcut_sayfa -= 1
		_sayfayi_guncelle()


func _sayfayi_guncelle() -> void:
	var veri: Dictionary = sayfalar[mevcut_sayfa]
	
	if baslik_label:
		baslik_label.text = veri["baslik"]
	if gorsel and veri["gorsel"] != null:
		gorsel.texture = veri["gorsel"]
	if aciklama_label:
		aciklama_label.text = veri["yazi"]
	if sayfa_label:
		sayfa_label.text = str(mevcut_sayfa + 1) + " / " + str(sayfalar.size())
		
	if geri_butonu:
		geri_butonu.disabled = (mevcut_sayfa == 0)
	if ileri_butonu:
		ileri_butonu.disabled = (mevcut_sayfa == sayfalar.size() - 1)


# --- BÖLÜM SEÇİM BUTONLARI ---

func _on_bolum_1_pressed() -> void:
	_harita_ac("res://scenes/harita1.tscn")


func _on_bolum_2_pressed() -> void:
	_harita_ac("res://scenes/harita2.tscn")


func _on_bolum_3_pressed() -> void:
	_harita_ac("res://scenes/harita3.tscn")


# --- YARDIMCI FONKSİYONLAR ---

func _panelleri_yonet(hedef_panel: Panel) -> void:
	if ayarlar_paneli:
		ayarlar_paneli.visible = (hedef_panel == ayarlar_paneli)
	if bolumler_paneli:
		bolumler_paneli.visible = (hedef_panel == bolumler_paneli)
	if nasil_oynanir_paneli:
		nasil_oynanir_paneli.visible = (hedef_panel == nasil_oynanir_paneli)
	if ana_butonlar:
		ana_butonlar.hide()


func _harita_ac(harita_yolu: String) -> void:
	get_tree().change_scene_to_file(harita_yolu)
