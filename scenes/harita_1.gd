extends TileMapLayer

# ESC tuşuna basıldığında menüyü açıp/kapatır
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_duraklat()

# Duraklatma durumunu tersine çeviren ortak fonksiyon
func toggle_duraklat() -> void:
	var durduruldu = !get_tree().paused
	get_tree().paused = durduruldu
	%DuraklatPaneli.visible = durduruldu

# DEVAM ET butonuna basılınca
func _on_devam_et_butonu_pressed() -> void:
	toggle_duraklat()

# Sol üstteki DURAKLAT butonuna basılınca
func _on_duraklat_butonu_pressed() -> void:
	toggle_duraklat()

# ANA MENÜYE DÖN butonuna basılınca
func _on_ana_menu_butonu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/anamenuu.tscn")

# OYUNDAN ÇIK butonuna basılınca
func _on_cikis_butonu_pressed() -> void:
	get_tree().quit()


func _on_duraklat_butonu_mouse_entered() -> void:
	pass # Replace with function body.


func _on_yeniden_basla_butonu_pressed() -> void:
	get_tree().paused = false  # Oyun duraklatılmışsa dondurmayı kaldırır
	get_tree().reload_current_scene()  # O an açık olan haritayı sıfırdan yeniden yükler
