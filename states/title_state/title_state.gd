extends Control

func _on_button_pressed() -> void:
	if is_instance_valid(GlobalStateManager):
		GlobalStateManager.switch_global_state(GlobalStateManager.GameState.GAMEPLAY)
