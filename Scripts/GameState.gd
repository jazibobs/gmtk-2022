extends Node

var timer_active = false
var active_rooms = [true, true, true, true, true, true]
var complete_rooms = [false, false, false, false, false, false]
var current_health = 3
var show_player_ui = false

var next_scene_path = "res://Scenes/Levels/Menu.tscn"
