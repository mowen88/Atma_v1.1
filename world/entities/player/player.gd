extends CharacterBody2D
class_name Player

const SPEED = 75.0
const JUMP_VELOCITY = -280.0
const MAX_JUMPS = 2

@onready var fsm = $FiniteStateMachine
var direction = 0
var gravity = 900.0
var jump_counter = 0

var current_tilemap: TileMapLayer = null

func x_input():
	direction = Input.get_axis("move_left", "move_right")

#
#func _check_if_on_slope_tile() -> bool:
	## 1. Reach out to the Master GameplayState scene root
	#var gameplay_state = get_tree().root.get_node_or_null("GameplayState")
	#var room_container = gameplay_state.get_node_or_null("CurrentRoom")
	#
	## 3. Find the TileMapLayer sitting inside the active room node
	#var tilemap_layer: TileMapLayer = room_container.find_child("TileMapLayer", true, false) as TileMapLayer
#
#
	## 4. RUN DETECTION MATH (Since paths are now 100% verified)
	## Target a sampling offset point 4 pixels down past the player's feet location
	#var check_position = actor.global_position + Vector2(0, 4)
	#
	## Convert global scene coordinates to tile-specific coordinate data pairs
	#var local_pos = tilemap_layer.to_local(check_position)
	#var tile_coords = tilemap_layer.local_to_map(local_pos)
	#
	## Extract cell metadata payload
	#var tile_data: TileData = tilemap_layer.get_cell_tile_data(tile_coords)
	#if tile_data:
		#return tile_data.get_custom_data("is_slope")
		#
	#return false

	
