extends Button


func _on_pressed() -> void:
	GameManager.bg_music_play("res://Audio/shoveling_beat.ogg")
	GameManager.change_scene("res://Scenes/game.tscn")
