extends Node

enum GameState { SPLASH, TITLE, CINEMATIC, GAMEPLAY }

const SCENES = {
	GameState.SPLASH: "res://states/splash_state/splash_state.tscn",
	GameState.TITLE: "res://states/title_state/title_state.tscn",
	GameState.CINEMATIC: "res://states/cinematic_state/cinematic_state.tscn",
	GameState.GAMEPLAY: "res://states/gameplay_state/gameplay_state.tscn"
}

# RULE REMINDER: No TRANSITION_SCENE preload constants allowed here anymore!

func switch_global_state(target_state: GameState) -> void:
	# 1. Use the global Autoload keyword directly. No instantiation required.
	# Replace 'Transition' with whatever name you set in your Autoload settings.
	TransitionManager.fade_to_state(func() -> void:
		# This code block executes safely while the screen is completely black!
		var target_path = SCENES[target_state]
		get_tree().change_scene_to_file(target_path)
		print("[CORE] Context changed natively to: ", GameState.keys()[target_state])
	)
	
	# 2. DELETE the animation_finished connection block entirely.
	# The global Autoload persists throughout the lifetime of the game,
	# so you do not want to queue_free() it!
