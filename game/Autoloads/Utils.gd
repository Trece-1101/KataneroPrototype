extends Node

#### Metodos
static func get_aim_joystick_direction() -> Vector2:
	return get_aim_joystick_strenght().normalized()

static func get_aim_joystick_strenght() -> Vector2:
	var deadzone_radius: float = 0.5
		
	var input_strenght: Vector2 = Vector2(
		Input.get_action_strength("aim_joy_right") - Input.get_action_strength("aim_joy_left"),
		Input.get_action_strength("aim_joy_down") - Input.get_action_strength("aim_joy_up")
	)
	
	if not input_strenght.length() > deadzone_radius:
		return Vector2.ZERO
		
	return input_strenght


static func get_keyboard_move_strenght() -> Vector2:
		return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 1.0
	)
