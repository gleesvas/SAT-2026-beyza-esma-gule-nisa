extends Area2D

@export var texture_up: Texture2D
@export var texture_down: Texture2D
@export var target_asansor: Node2D

var is_down: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if texture_up and $Sprite2D:
		$Sprite2D.texture = texture_up

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		is_down = !is_down
		print("Şaltere basıldı! Yeni durum: ", is_down)
		
		if $Sprite2D:
			$Sprite2D.texture = texture_down if is_down else texture_up
			
		if target_asansor and target_asansor.has_method("toggle"):
			target_asansor.toggle(is_down)
		else:
			print("HATA: Target Asansor bağlı değil veya toggle metodu yok!")
