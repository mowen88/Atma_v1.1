extends State

@export var move_speed: float = 200.0

func enter() -> void:
	if actor.has_node("AnimationPlayer"):
		actor.get_node("AnimationPlayer").play("run")

func physics_update(delta: float) -> void:
	if not actor.is_on_floor():
		actor.velocity += actor.get_gravity() * delta

	var input_dir = Input.get_axis("move_left", "move_right")
	if input_dir == 0:
		fsm.change_state("Idle")
		return

	actor.velocity.x = input_dir * move_speed
	actor.move_and_slide()
