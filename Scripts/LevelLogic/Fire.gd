extends Node2D


func _on_DeathZone_body_entered(body):
	GameState.active_rooms[0] = false
	GameState.next_scene_path = "res://Scenes/Levels/Hub.tscn"
