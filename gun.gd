extends Sprite2D

func _physics_process(delta: float) -> void:
	rotation = lerp_angle(rotation, ( get_global_mouse_position() - global_position ).angle() * deg_to_rad(90), 6.5*delta)
