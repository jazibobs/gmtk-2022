extends Node2D


func _on_DeathZone_body_entered(_body):
	$DeathZone/AudioStreamPlayer.play()


func _on_WinArea_body_entered(body):
	if body.name == "KinematicBody2D":
		$WinArea/AudioStreamPlayer.play()
		GameState.complete_rooms[0] = true


func _on_AudioStreamPlayer_finished():
	GameState.next_scene_path = "res://Scenes/Levels/Hub.tscn"
