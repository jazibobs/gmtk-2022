extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var current_scene = load("res://Scenes/Levels/Menu.tscn").instance()
	$CurrentScene.add_child(current_scene)
