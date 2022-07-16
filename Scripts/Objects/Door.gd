extends Node2D

export (int) var level_number
export (bool) var is_open = false


func _ready():
	print(level_number)
	$DiceLabel.frame = level_number - 1

func _process(_delta):
	if is_open:
		$Doorway.frame = 1
		$DiceLabel.modulate.a = 255
	else:
		$Doorway.frame = 0
