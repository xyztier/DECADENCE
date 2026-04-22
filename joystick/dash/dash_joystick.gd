class_name DashJoystick extends Joystick


@export var player: Player:
	get:
		if not player:
			player = get_tree().get_first_node_in_group("Player")
		return player


var in_cooldown: bool = false


func _move_joystick(pos: Vector2) -> void:
	if in_cooldown:
		return

	super(pos)
	Game.dash_joystick_position = dir.normalized()


func _release_joystick() -> void:
	super()

	in_cooldown = true
	Game.dash_joystick_released = true

	await get_tree().create_timer(player.dash_recharge_time).timeout

	in_cooldown = false
	Game.dash_joystick_position = Vector2.ZERO
	Game.dash_joystick_released = false
