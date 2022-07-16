extends Node2D

export (int) var level_number
export (bool) var is_open = false

var can_enter = false


func _ready():
	$DiceLabel.frame = level_number - 1

func _process(_delta):
	if is_open:
		$Doorway.frame = 1
		$DiceLabel.modulate.a = 255
	else:
		$Doorway.frame = 0
	
	if can_enter and Input.is_action_pressed("enter_door"):
		if level_number == 1:
			get_tree().change_scene("res://Scenes/Fire.tscn")
		elif level_number == 2:
			get_tree().change_scene("res://Scenes/Ice.tscn")
		elif level_number == 3:
			get_tree().change_scene("res://Scenes/Underwater.tscn")
		elif level_number == 4:
			get_tree().change_scene("res://Scenes/Trivia.tscn")
		elif level_number == 5:
			get_tree().change_scene("res://Scenes/Bullet.tscn")
		elif level_number == 6:
			get_tree().change_scene("res://Scenes/Serenity.tscn")


func _on_Area2D_body_entered(body):
	if body.get_parent().name == "Player":
		can_enter = true


func _on_Area2D_body_exited(body):
	if body.get_parent().name == "Player":
		can_enter = false
