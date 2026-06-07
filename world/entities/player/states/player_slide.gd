extends State
class_name Slide

const SLIDE_SPEED = 120

func enter():
	print("Entering slide state")
	
	actor.get_node("AnimatedSprite2D").play("slide")

func physics_update(delta):
	# 1. Force the steady down-and-left 45-degree vector
	var velocity = Vector2(-1, 1).normalized()
	actor.velocity = velocity * SLIDE_SPEED
	actor.move_and_slide()
