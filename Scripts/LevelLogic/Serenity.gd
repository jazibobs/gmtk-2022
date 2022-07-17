extends Node2D


func _ready():
	GameState.complete_rooms[5] = true
	$AudioStreamPlayer.play()
