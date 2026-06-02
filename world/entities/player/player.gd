extends CharacterBody2D

const SPEED = 75.0
const JUMP_VELOCITY = -280.0
const MAX_JUMPS = 2

var gravity = 900.0
var jump_counter = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Reset jump counter when touching the ground
		jump_counter = 0

	# Handle jump using your clean 'jump' input action
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif jump_counter < 1:
			velocity.y = JUMP_VELOCITY
			jump_counter += 1 # Increments for the double jump
			
	# Get the input direction using your clean gameplay axis mappings
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
