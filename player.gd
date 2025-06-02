extends CharacterBody2D
var SPEED = 400
var GRAVITY = 1200
var JUMP_FORCE = -600
var is_rolling = false
var roll_duration = 0.5
var roll_timer = 0.0
var is_idle = true
@onready var anim = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
	
func _physics_process(delta: float) -> void:

	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
	velocity.x = direction.x * SPEED
	
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0
		
	if direction.x != 0:
		anim.flip_h = direction.x < 0
	
	# JUMP
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		anim.play("jump")
	
	# ROLL
	if Input.is_action_just_pressed("roll") and is_on_floor() and not is_rolling and not is_idle:
		is_rolling = true
		roll_timer = roll_duration
		anim.play("roll")
	if is_rolling:
		roll_timer -= delta
		if roll_timer <= 0.0:
			is_rolling = false
	
	move_and_slide()
	if not is_rolling:
		if is_on_floor():
			if direction.x != 0:
				anim.play("run")
				is_idle = false
			else:
				anim.play("idle")
				is_idle = true
		else:
			anim.play("jump")
			is_idle = false
