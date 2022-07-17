extends Node2D


var rng = RandomNumberGenerator.new()
var dice_random_number = 0

func _ready():
	var rerolls = 20
	dice_random_number = rng.randi_range(0, 5)

	while GameState.active_rooms[dice_random_number] and rerolls < 0:
		dice_random_number = rng.randi_range(0, 5)
		rerolls -= 1
		print("Next roll:", dice_random_number + 1)

func _on_DiceTicker_timeout():
	var dice_random_face= rng.randi_range(0, 5)
	$StaticBody2D/AnimatedSprite.frame = dice_random_face


func _on_Area2D_body_entered(body):
	if body.get_parent().name == "Player":
		$DiceTicker.stop()
		$StaticBody2D/AnimatedSprite.stop()
		$StaticBody2D/AnimatedSprite.frame = dice_random_number
		
		# Unlock door
		GameState.active_rooms[dice_random_number] = true
	
