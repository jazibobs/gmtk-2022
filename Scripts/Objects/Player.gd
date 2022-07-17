extends Node2D

const UP = Vector2(0,-1)
const GRAVITY = 40
const MAXFALLSPEED = 600
const MAXSPEED = 450
const JUMPFORCE = 800
const ACCEL = 100

var motion = Vector2()
var facing_right = true
var health = 3
var decay_rate = 0.2
	
func _physics_process(_delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if facing_right:
		$KinematicBody2D/AnimatedSprite.flip_h = false
	else:
		$KinematicBody2D/AnimatedSprite.flip_h = true
		
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		$KinematicBody2D/AnimatedSprite.play("running")
		facing_right = true
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		$KinematicBody2D/AnimatedSprite.play("running")
		facing_right = false
	else:
		motion.x = lerp(motion.x, 0, decay_rate)
		$KinematicBody2D/AnimatedSprite.play("idle")
	
	if $KinematicBody2D.is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -JUMPFORCE
			
	if motion.y < 0 and !$KinematicBody2D.is_on_floor():
		$KinematicBody2D/AnimatedSprite.play("jump")
	elif motion.y > 0 and !$KinematicBody2D.is_on_floor():
		$KinematicBody2D/AnimatedSprite.play("fall")
	
	motion = $KinematicBody2D.move_and_slide(motion, UP)


func _on_GroundMonitor_body_entered(body):
	if body.name == "IceMap":
		decay_rate = 0.05
