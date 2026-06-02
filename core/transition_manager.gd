extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	color_rect.color.a = 0.0
	color_rect.visible = false

func fade_to_state(on_mid_transition: Callable) -> void:
	color_rect.visible = true
	animation_player.play("fade_to_black")
	
	await animation_player.animation_finished
	
	if on_mid_transition.is_valid():
		on_mid_transition.call()
		
	animation_player.play("fade_to_normal")
