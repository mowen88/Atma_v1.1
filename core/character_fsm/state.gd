
# Description: Base class blueprint for all individual states

extends Node
class_name State

var fsm: FiniteStateMachine
var actor: CharacterBody2D

func enter() -> void:
	pass

func exit() -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
