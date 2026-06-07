extends State

class_name Transitioning

func enter():
	print("Entering transitioning state")

	actor.get_node("AnimatedSprite2D").play("run")
	
	var timer: float = 0.5
	
	get_tree().create_timer(timer).timeout.connect(func() -> void:
		fsm.change_state("fall")
	)

func physics_update(delta):
	
	# Add gravity
	actor.velocity.y += actor.gravity * delta
	
	# Apply physics without the input
	actor.velocity.x = actor.direction * 100
	actor.move_and_slide()

	
	
