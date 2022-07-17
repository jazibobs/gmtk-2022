extends Control


func _ready():
	pass # Replace with function body.


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_StartButton_pressed():
	var hub_instance = load("res://Scenes/Levels/Hub.tscn").instance()
	GameState.timer_active = true
	get_parent().add_child(hub_instance)
	get_parent().remove_child(self)
