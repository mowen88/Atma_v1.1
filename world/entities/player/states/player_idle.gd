# res://player/states/player_idle.gd
extends State

func enter() -> void:
	# Clean horizontal stop on entry
	actor.velocity.x = 0
	
	if actor.has_node("AnimationPlayer"):
		actor.get_node("AnimationPlayer").play("idle")

func physics_update(delta: float) -> void:
	# Fallback gravity calculation if they slip off an edge while standing still
	if not actor.is_on_floor():
		actor.velocity += actor.get_gravity() * delta
		actor.move_and_slide()
		return

	# Gather input vector (-1.0, 0.0, or 1.0)
	var input_dir: float = Input.get_axis("move_left", "move_right")
	
	# Switch to Run state immediately if horizontal movement is requested
	if input_dir != 0:
		fsm.change_state("Run")
