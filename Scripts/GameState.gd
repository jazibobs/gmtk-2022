extends Node

var win_state = false
var timer_active = false
var active_rooms = [true, true, true, true, true, false]
var complete_rooms = [true, true, true, true, true, false]
var current_health = 3
var show_player_ui = false

var next_scene_path = "res://Scenes/Levels/Menu.tscn"
