extends Area2D

func _ready() -> void:
	# Connect the collision physics signal
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Verify it's the player character passing through
	if body is Player:
		# Convert this door node's string name (e.g., "1", "2", "3") into an integer ID
		var exit_id: int = int(self.name)
		body.fsm.change_state("transitioning")
		
		# Locate the master game manager node
		var gameplay_state = get_tree().root.get_node_or_null("GameplayState")
		if gameplay_state:
			print("[DOOR] Player entered exit trigger: ", exit_id, ". Sending to engine...")
			# CALL THE NEW DYNAMIC FUNCTION HERE:
			gameplay_state.transition_to_next_room(exit_id)
		else:
			print("[ERROR] Door couldn't find the 'GameplayState' root node!")
