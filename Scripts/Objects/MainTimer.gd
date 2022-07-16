extends Control

var milliseconds = 0
var seconds = 0
var minutes = 0

func _on_Timer_timeout():
	milliseconds += 1
	
	if milliseconds == 10:
		seconds += 1
		milliseconds = 0
	
	if seconds == 60:
		minutes += 1
		seconds = 0
		
	var format_time = "%02d:%02d.%01d" % [minutes, seconds, milliseconds]
	$Label.text = format_time
