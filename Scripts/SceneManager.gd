extends Node


onready var current_scene = load("res://Scenes/Levels/Menu.tscn").instance()
var has_won = false

func _ready():
	$CurrentScene.add_child(current_scene)

func _process(_delta):
	if GameState.win_state == false:
		$UILayer/WinMessage.visible = false
	else:
		$UILayer/WinMessage.visible = true
		
	if current_scene.filename != GameState.next_scene_path:
		change_scene(GameState.next_scene_path)
	
	for x in range (0, 6):
		get_node("UILayer/CompletedRooms/Room" + str(x+1)).modulate.a = 0.5
		
		if GameState.complete_rooms[x]:
			get_node("UILayer/CompletedRooms/Room" + str(x+1)).modulate.a = 1
	
	# Check for win condition
	has_won = true
	for x in range(0, 6):
		# Must be in the Hub to win
		if current_scene.filename != "res://Scenes/Levels/Hub.tscn":
			has_won = false
	
		if !GameState.complete_rooms[x]:
			has_won = false
			
	if has_won:
		GameState.timer_active = false
		GameState.win_state = true
	
func change_scene(scene_path):
	print("Scene change to:", scene_path)
	var new_scene = load(scene_path).instance()
	$CurrentScene.remove_child(current_scene)
	$CurrentScene.add_child(new_scene)
	current_scene = new_scene
