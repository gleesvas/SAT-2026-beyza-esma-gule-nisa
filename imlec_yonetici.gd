extends Node

var imlec_tex_normal: ImageTexture
var imlec_tex_tiklama: ImageTexture

func _ready() -> void:
	_imlec_sistemini_kur()

func _imlec_sistemini_kur() -> void:
	var imlec_yolu := "res://imlec.png" # Kendi imleç resminin tam yolu
	
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
		
		# Varsayılan imleci atayalım
		Input.set_custom_mouse_cursor(imlec_tex_normal, Input.CURSOR_ARROW, Vector2(0, 0))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if imlec_tex_tiklama:
				Input.set_custom_mouse_cursor(imlec_tex_tiklama, Input.CURSOR_ARROW, Vector2(0, 0))
		else:
			if imlec_tex_normal:
				Input.set_custom_mouse_cursor(imlec_tex_normal, Input.CURSOR_ARROW, Vector2(0, 0))
