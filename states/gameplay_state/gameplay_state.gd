extends Node2D

@onready var current_room_container: Node2D = $CurrentRoom
@onready var player: CharacterBody2D = $Player
@onready var game_camera: Camera2D = $GameCamera
@onready var camera_target: Node2D = $CameraTarget

var current_room_node: Node2D = null
var is_in_cutscene: bool = false

func _ready() -> void:
	print("[GAMEPLAY] Stage initialized. Core entities are persistent.")
	# Bootstraps the first room immediately
	_load_room("res://world/rooms/a_01.tscn", 0)

func inject_room_dependencies_to_player(room_node: Node2D) -> void:
	var active_tilemap = room_node.get_node_or_null("TileMapLayer") as TileMapLayer
	player.current_tilemap = active_tilemap
	print("Handed fresh tilemap to player!)") 

func _process(_delta: float) -> void:
	if not is_in_cutscene and player:
		camera_target.global_position = player.global_position

func transition_to_next_room(exit_id: int) -> void:
	if not current_room_node:
		return
		
	var current_room_name = current_room_node.name.to_lower()
	
	if MapData.MAP_DATA.has(current_room_name) and MapData.MAP_DATA[current_room_name].has(exit_id):
		var target_room_name: String = MapData.MAP_DATA[current_room_name][exit_id]
		var target_room_path: String = "res://world/rooms/" + target_room_name + ".tscn"
		
		_execute_room_swap(target_room_path, exit_id)

## Triggers the visual screen transition and schedules the clean room swap logic
func _execute_room_swap(next_room_path: String, target_spawn_id: int) -> void:

	# Call global transition instance
	TransitionManager.fade_to_state(func() -> void:
		#player.set_physics_process(false)
		
		# Clear out the previous room layout before loading the new one
		for child in current_room_container.get_children():
			child.queue_free()
		
		_load_room(next_room_path, target_spawn_id)
		
		#player.set_physics_process(true)
	)

## Instantiating and setting up any room
func _load_room(room_path: String, spawn_id: int) -> void:
	current_room_node = null
	
	# disable camera smoothing
	game_camera.position_smoothing_enabled = false
	
	var next_room_scene = load(room_path)
	if next_room_scene:
		
		current_room_node = next_room_scene.instantiate()
		current_room_container.add_child(current_room_node)
		
		var spawn_node = current_room_node.get_node_or_null("Spawns/" + str(spawn_id))
		if spawn_node:
			# Set the player position to the spawn node
			player.global_position = spawn_node.global_position

		else:
			# Fallback if ther eis no spawn node (for future custom positioning?)
			if spawn_id != 0:
				player.global_position = Vector2(100, 250)
				print("[WARN] Spawn ID ", spawn_id, " not found. Fallback used.")
		
		# Populate the room references to the player
		inject_room_dependencies_to_player(current_room_node)
		print(player.current_tilemap)
		# Handle camera boundaries, targets, and matrix synchronization
		_snap_camera_to_current_room()
		
		# wait for one process frame and reeanable the camera smoothing
		await get_tree().process_frame
		game_camera.position_smoothing_enabled = true

	else:
		print("[ERROR] Failed to load room at path: ", room_path)

## Update boundaries and instantly snap the camera
func _snap_camera_to_current_room() -> void:
	if not current_room_node:
		return
		
	# Establish the boundary walls
	_update_camera_limits(current_room_node)
	# Align your tracking anchor node directly to the player's location
	camera_target.global_position = player.global_position
	
func _update_camera_limits(room_node: Node2D) -> void:
	var limits = room_node.get_node_or_null("Limits") as ReferenceRect
	if limits:
		game_camera.limit_left = int(limits.global_position.x)
		game_camera.limit_top = int(limits.global_position.y)
		game_camera.limit_right = int(limits.global_position.x + limits.size.x)
		game_camera.limit_bottom = int(limits.global_position.y + limits.size.y)
