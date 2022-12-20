extends Camera2D

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_released("scroll_up"):
		zoom /= 1.1
	if Input.is_action_just_released("scroll_down"):
		zoom *= 1.1
