extends Node2D


func _ready():
	$Player.is_swimming = true


func _on_WinArea_body_entered(body):
	if body.name == "KinematicBody2D":
		$WinArea/AudioStreamPlayer.play()
		GameState.complete_rooms[2] = true
