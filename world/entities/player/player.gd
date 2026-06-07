extends CharacterBody2D
class_name Player

const SPEED = 75.0
const JUMP_VELOCITY = -280.0
const MAX_JUMPS = 2

@onready var fsm = $FiniteStateMachine
var direction = 0
var gravity = 900.0
var jump_counter = 0

func x_input():
	direction = Input.get_axis("move_left", "move_right")
	
