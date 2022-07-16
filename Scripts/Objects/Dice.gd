extends Node2D


var rng = RandomNumberGenerator.new()
var dice_random_number = 0

func _ready():
	rng.randomize()
	dice_random_number = rng.randi_range(0, 5)


func _on_DiceTicker_timeout():
	dice_random_number = rng.randi_range(0, 5)
	$StaticBody2D/AnimatedSprite.frame = dice_random_number
