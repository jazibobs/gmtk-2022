extends Node


onready var current_scene = load("res://Scenes/Levels/Menu.tscn").instance()

func _ready():
	$CurrentScene.add_child(current_scene)

func _process(_delta):
	if current_scene.filename != GameState.next_scene_path:
		change_scene(GameState.next_scene_path)
	
	for x in range (0, 6):
		get_node("UILayer/CompletedRooms/Room" + str(x+1)).modulate.a = 0.5
		
		if GameState.complete_rooms[x]:
			get_node("UILayer/CompletedRooms/Room" + str(x+1)).modulate.a = 1

func change_scene(scene_path):
	print("Scene change to:", scene_path)
	var new_scene = load(scene_path).instance()
	$CurrentScene.remove_child(current_scene)
	$CurrentScene.add_child(new_scene)
	current_scene = new_scene
