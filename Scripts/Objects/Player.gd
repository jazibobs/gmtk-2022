extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 40
const MAXFALLSPEED = 600
const MAXSPEED = 450
const JUMPFORCE = 800
const ACCEL = 100

var motion = Vector2()
var facing_right = true

func _ready():
	pass
	
func _physics_process(_delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if facing_right:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
		
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		$AnimatedSprite.play("running")
		facing_right = true
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		$AnimatedSprite.play("running")
		facing_right = false
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimatedSprite.play("idle")
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -JUMPFORCE
			
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	elif motion.y > 0 and !is_on_floor():
		$AnimatedSprite.play("fall")
	
	motion = move_and_slide(motion, UP)
