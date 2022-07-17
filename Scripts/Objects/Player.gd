extends Node2D

const UP = Vector2(0,-1)
const GRAVITY = 40
const SWIM_GRAVITY = 20
const MAXFALLSPEED = 600
const SWIM_MAXFALLSPEED = 300
const MAXSPEED = 450
const SWIM_MAXSPEED = 100
const JUMPFORCE = 800
const SWIMFORCE = 300
const ACCEL = 100
const SWIM_ACCEL = 50

var motion = Vector2()
var facing_right = true
var health = 3
var decay_rate = 0.2
var is_swimming = false
var is_dead = false
	
func _physics_process(_delta):
	
	if facing_right:
		$KinematicBody2D/AnimatedSprite.flip_h = false
	else:
		$KinematicBody2D/AnimatedSprite.flip_h = true
	
	
	
	if is_swimming and !is_dead:
		$KinematicBody2D/AnimatedSprite.play("swimming")
		
		motion.y += SWIM_GRAVITY
		if motion.y > SWIM_MAXFALLSPEED:
			motion.y = SWIM_MAXFALLSPEED
		
		motion.x = clamp(motion.x, -SWIM_MAXSPEED, SWIM_MAXSPEED)
		
		if Input.is_action_pressed("right"):
			motion.x += SWIM_ACCEL
			facing_right = true
		elif Input.is_action_pressed("left"):
			motion.x -= SWIM_ACCEL
			$KinematicBody2D/AnimatedSprite.play("running")
			facing_right = false
		
		if Input.is_action_pressed("jump"):
				motion.y = -SWIMFORCE
				$JumpingSound.play()
	
	elif !is_dead:
			
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
			
		if Input.is_action_pressed("right"):
			motion.x += ACCEL
			$KinematicBody2D/AnimatedSprite.play("running")
			if !$WalkingSound.playing and $KinematicBody2D.is_on_floor():
				$WalkingSound.play()
			facing_right = true
		elif Input.is_action_pressed("left"):
			motion.x -= ACCEL
			$KinematicBody2D/AnimatedSprite.play("running")
			if !$WalkingSound.playing and $KinematicBody2D.is_on_floor():
				$WalkingSound.play()
			facing_right = false
		else:
			motion.x = lerp(motion.x, 0, decay_rate)
			$KinematicBody2D/AnimatedSprite.play("idle")
		
		if $KinematicBody2D.is_on_floor():
			if Input.is_action_pressed("jump"):
				$JumpingSound.play()
				motion.y = -JUMPFORCE
				
		if motion.y < 0 and !$KinematicBody2D.is_on_floor():
			$KinematicBody2D/AnimatedSprite.play("jump")
		elif motion.y > 0 and !$KinematicBody2D.is_on_floor():
			$KinematicBody2D/AnimatedSprite.play("fall")
		
	motion = $KinematicBody2D.move_and_slide(motion, UP)


func _on_GroundMonitor_body_entered(body):
	
	if body.name == "IceMap":
		decay_rate = 0.05
		
func _on_GroundMonitor_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.name == "Hitbox":
		$KinematicBody2D/AnimatedSprite.modulate.a = 0
		is_dead = true
		if !$HurtNoise.playing():
			$HurtNoise.play()
		


func _on_HurtNoise_finished():
	GameState.next_scene_path = "res://Scenes/Levels/Hub.tscn"
