extends Node2D

var time_remaining = 3000
var new_enemy_instance

func _ready():
	var swimmer_enemy = load("res://Objects/Enemies/SwimEnemy.tscn")
	
	for x in range(0, 10):
		new_enemy_instance = swimmer_enemy.instance()
		new_enemy_instance.position.x -= 300 * x
		$EnemySpawn.add_child(new_enemy_instance)
		
	for x in range(0, 10):
		new_enemy_instance = swimmer_enemy.instance()
		new_enemy_instance.position.x += 300 * x
		new_enemy_instance.get_node("AnimatedSprite").flip_h = true
		$EnemySpawn2.add_child(new_enemy_instance)

func _physics_process(delta):
	for enemy in $EnemySpawn.get_children():
		enemy.position.x += 250 * delta
	
	for enemy in $EnemySpawn2.get_children():
		enemy.position.x -= 150 * delta

func _on_DeathZone_body_entered(_body):
	GameState.next_scene_path = "res://Scenes/Levels/Hub.tscn"


func _on_Coundown_timeout():
	time_remaining -= 10
	$CanvasLayer/ColorRect.rect_position.x += 4.25
	
	if time_remaining <= 0:
		GameState.complete_rooms[4] = true
		GameState.next_scene_path = "res://Scenes/Levels/Hub.tscn"
	
	
