extends Node2D


func _ready():
	GameState.complete_rooms[0] = true

func _on_DeathZone_body_entered(body):
	GameState.complete_rooms[0] = false
	GameState.next_scene_path = "res://Scenes/Levels/Hub.tscn"
