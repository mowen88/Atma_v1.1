extends State

class_name Fall

func enter():
	print("Entering fall state")
	actor.get_node("AnimatedSprite2D").play("run")

func physics_update(delta):
	# 1. Apply regular gravity while falling
	actor.velocity.y += actor.gravity * delta
	
	# 2. Process movement so actor.is_on_floor() becomes true when landing
	actor.move_and_slide()
	
	# 3. Create a local variable to explicitly track our slope status
	var collided_with_slope: bool = false
	
	if actor.is_on_floor():
		# Run our tile scanning logic and store it in our variable
		collided_with_slope = _check_if_on_slope_tile()
		
		# PRINT DIAGNOSTICS: Let's see what the engine is doing!
		print("[FALL DIAGNOSTIC] Player is on floor. collided_with_slope = ", collided_with_slope)
		
		if collided_with_slope:
			fsm.change_state("slide")
		else:
			print("[FALL] Normal floor detected. Switching to idle.")
			fsm.change_state("idle")
			return
			
	# 4. Regular Air Control (only runs while airborne)
	actor.x_input()
	actor.velocity.x = actor.direction * 100.0


func _check_if_on_slope_tile() -> bool:
	# 1. Reach out to the Master GameplayState scene root
	var gameplay_state = get_tree().root.get_node_or_null("GameplayState")
	var room_container = gameplay_state.get_node_or_null("CurrentRoom")
	
	# 3. Find the TileMapLayer sitting inside the active room node
	var tilemap_layer: TileMapLayer = room_container.find_child("TileMapLayer", true, false) as TileMapLayer


	# 4. RUN DETECTION MATH (Since paths are now 100% verified)
	# Target a sampling offset point 4 pixels down past the player's feet location
	var check_position = actor.global_position + Vector2(0, 4)
	
	# Convert global scene coordinates to tile-specific coordinate data pairs
	var local_pos = tilemap_layer.to_local(check_position)
	var tile_coords = tilemap_layer.local_to_map(local_pos)
	
	# Extract cell metadata payload
	var tile_data: TileData = tilemap_layer.get_cell_tile_data(tile_coords)
	if tile_data:
		return tile_data.get_custom_data("is_slope")
		
	return false
