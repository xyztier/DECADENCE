class_name MoveJoystick extends Joystick


func _ready() -> void:
	global_position.x = 288.0 # Temporary (also in dash_joystick)
	super()


func _control_joystick(pos: Vector2) -> void:
	super(pos)
	Game.move_joystick_position = dir.normalized()


func _release_joystick() -> void:
	super()
	Game.move_joystick_position = Vector2.ZERO
