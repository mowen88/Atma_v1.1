extends Node

class_name FiniteStateMachine

@export var initial_state: State

var current_state: State

var states: Dictionary = {}

func _ready() -> void:
	# register all states
	for state in get_children():
		if state is State:
			states[state.name.to_lower()] = state
			state.fsm = self
			state.actor = get_parent()
	
	# Start on initial state
	if initial_state:
		change_state(initial_state.name.to_lower())
	
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
		print()

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state_name.to_lower())
	
	if current_state:
		current_state.enter()
	


	
