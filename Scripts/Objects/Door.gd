extends Node2D

export (int) var level_number
export (bool) var is_open = false

var can_enter = false
var door_unlocked = false
var level_path


func _ready():
	$DiceLabel.frame = level_number

func _process(_delta):
	
	if GameState.active_rooms[level_number - 1]:
		is_open = true
	
	if is_open:
		$Doorway.frame = 1
		$DiceLabel.modulate.a = 255
	else:
		$Doorway.frame = 0
	
	if can_enter and Input.is_action_pressed("enter_door"):
		if level_number == 0:
			level_path = "res://Scenes/Levels/Hub.tscn"
		elif level_number == 1:
			level_path = "res://Scenes/Levels/Fire.tscn"
		elif level_number == 2:
			level_path = "res://Scenes/Levels/Ice.tscn"
		elif level_number == 3:
			level_path = "res://Scenes/Levels/Underwater.tscn"
		elif level_number == 4:
			level_path = "res://Scenes/Levels/Trivia.tscn"
		elif level_number == 5:
			level_path = "res://Scenes/Levels/Bullet.tscn"
		elif level_number == 6:
			level_path = "res://Scenes/Levels/Serenity.tscn"
		
		GameState.next_scene_path = level_path


func _on_Area2D_body_entered(body):
	if body.get_parent().name == "Player" and is_open:
		can_enter = true


func _on_Area2D_body_exited(body):
	if body.get_parent().name == "Player":
		can_enter = false
