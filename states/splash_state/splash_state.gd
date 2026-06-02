extends Control

## The total duration (in seconds) the splash screen remains visible
@export var display_time: float = 1.0

func _ready() -> void:

	# Start a clean engine timer, then trigger the state transition
	get_tree().create_timer(display_time).timeout.connect(func() -> void:
		_transition_to_title()
	)

func _transition_to_title() -> void:
	print("[STATE] Splash display time elapsed. Handoff initiated.")
	
	# Safe guard check to ensure our Autoload singleton is live before execution
	if is_instance_valid(GlobalStateManager):
		GlobalStateManager.switch_global_state(GlobalStateManager.GameState.TITLE)
	else:
		push_error("[CRITICAL] GlobalStateManager singleton is missing from project scope!")
