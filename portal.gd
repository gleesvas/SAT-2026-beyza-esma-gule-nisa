extends Area2D

## Geçilecek harita yolu
@export_file("*.tscn") var next_scene_path: String = "res://scenes/harita2.tscn"

# Portala giren oyuncuların listesi
var players_in_portal: Array[Node2D] = []


func _ready() -> void:
	if $AnimatedSprite2D.sprite_frames and $AnimatedSprite2D.sprite_frames.has_animation("default"):
		$AnimatedSprite2D.play("default")
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players") and not body in players_in_portal:
		players_in_portal.append(body)
		print("Portala giren karakter: ", body.name, " | Portaldaki toplam: ", players_in_portal.size())
		_check_level_complete()


func _on_body_exited(body: Node2D) -> void:
	if body in players_in_portal:
		players_in_portal.erase(body)
		print("Portaldan çıkan karakter: ", body.name)


func _check_level_complete() -> void:
	var total_players := get_tree().get_nodes_in_group("players").size()
	var remaining_diamonds := get_tree().get_nodes_in_group("elmaslar").size()
	
	print("Sahnedeki Toplam Oyuncu: ", total_players, " | Portaldakiler: ", players_in_portal.size())
	print("Kalan Elmas Sayısı: ", remaining_diamonds)
	
	# Hem tüm oyuncular portala girmiş olmalı hem de hiç elmas kalmamış olmalı
	if players_in_portal.size() >= total_players and total_players > 0:
		if remaining_diamonds == 0:
			print("GEÇİŞ BAŞARILI: Sonraki haritaya geçiliyor...")
			call_deferred("_change_scene")
		else:
			print("GEÇİŞ ENGELLENDİ: Toplanması gereken ", remaining_diamonds, " elmas daha var!")


func _change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
