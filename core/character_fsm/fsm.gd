
## Ticks the active state and handles state transitions.
extends Node
class_name FiniteStateMachine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	# Initialize and map all child state nodes
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.fsm = self
			child.actor = get_parent() # Hooks up the Player CharacterBody2D
			
	if initial_state:
		current_state = initial_state
		current_state.enter()

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func change_state(new_state_name: String) -> void:
	var target_state = states.get(new_state_name.to_lower())
	if not target_state or target_state == current_state:
		return
		
	if current_state:
		current_state.exit()
		
	current_state = target_state
	current_state.enter()
