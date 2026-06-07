extends State
class_name Jump

func enter():
	print("Entering jump state")
	
	actor.get_node("AnimatedSprite2D").play("idle")
	
	actor.jump_counter += 1 # Increments for the double jump
	actor.velocity.y = actor.JUMP_VELOCITY
	
func physics_update(delta):
	# Add gravity
	actor.velocity.y += actor.gravity * delta
	
	# Handle horizontal movement
	actor.x_input()
	actor.velocity.x = actor.direction * 100
	actor.move_and_slide()
	
	if actor.velocity.y >= 0:
		fsm.change_state("fall")
