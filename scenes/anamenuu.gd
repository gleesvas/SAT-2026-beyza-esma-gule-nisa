extends Control


func _on_button_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/harita1.tscn")


func _on_cikisbuton_pressed() -> void:
		get_tree().quit()


func _on_ayarlarbuton_pressed() -> void:
		$AyarlarPaneli.visible = true


func _on_kapat_butonu_pressed() -> void:
		$AyarlarPaneli.visible = false


func _on_h_slider_value_changed(value: float) -> void:
		var bus_index = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
