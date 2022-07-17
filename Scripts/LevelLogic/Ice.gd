extends Node2D


func _on_WinArea_body_entered(body):
	if body.name == "KinematicBody2D":
		GameState.complete_rooms[1] = true
