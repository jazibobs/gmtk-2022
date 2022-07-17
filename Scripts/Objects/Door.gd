extends Node2D

export (int) var level_number
export (bool) var is_open = false

var can_enter = false
var door_unlocked = false
var level_instance


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
			level_instance = load("res://Scenes/Levels/Hub.tscn").instance()
		elif level_number == 1:
			level_instance = load("res://Scenes/Levels/Fire.tscn").instance()
		elif level_number == 2:
			level_instance = load("res://Scenes/Levels/Ice.tscn").instance()
		elif level_number == 3:
			level_instance = load("res://Scenes/Levels/Underwater.tscn").instance()
		elif level_number == 4:
			level_instance = load("res://Scenes/Levels/Trivia.tscn").instance()
		elif level_number == 5:
			level_instance = load("res://Scenes/Levels/Bullet.tscn").instance()
		elif level_number == 6:
			level_instance = load("res://Scenes/Levels/Serenity.tscn").instance()
		
		get_parent().get_parent().add_child(level_instance)
		get_parent().get_parent().remove_child(self.get_parent())


func _on_Area2D_body_entered(body):
	if body.get_parent().name == "Player" and is_open:
		can_enter = true


func _on_Area2D_body_exited(body):
	if body.get_parent().name == "Player":
		can_enter = false
