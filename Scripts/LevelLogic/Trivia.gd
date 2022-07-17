extends Node2D


var green_active = false
var red_active = false

	

func _on_GreenButton_body_entered(body):
	if !body.is_on_floor() and !green_active and !red_active:
		green_active = true
		$GreenButton/AnimatedSprite.frame = 1
		$GreenButton/AnimatedSprite.translate(Vector2(0, 7))
		$NPC/Question.text = "Nice work! You can now exit the level."
		$NPC/AnswerGreen.text = ""
		$NPC/AnswerRed.text = ""
		GameState.complete_rooms[3] = true
		$DiceDoor.is_open = true


func _on_RedButton_body_entered(body):
	if !body.is_on_floor()and !red_active and !green_active:
		red_active = true
		$RedButton/AnimatedSprite.frame = 1
		$RedButton/AnimatedSprite.translate(Vector2(0, 7))
		$NPC/Question.text = "Sorry that's incorrect"
		$NPC/AnswerGreen.text = ""
		$NPC/AnswerRed.text = ""
		$LevelEnd.start()


func _on_LevelEnd_timeout():
	GameState.next_scene_path = "res://Scenes/Levels/Hub.tscn"
