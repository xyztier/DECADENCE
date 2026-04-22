class_name Enemy extends Entity


@export var move_speed: float = 700.0
@export var attack_distance: float = 300.0 # In pixels? idk

@export var player: Player:
	get:
		if not player:
			player = get_tree().get_first_node_in_group("Player")
		return player


enum State {
	IDLE,
	CHASING,
	ATTACKING,
}

var current_state: State = State.IDLE


@onready var state_label: Label = $StateLabel


func _physics_process(delta: float) -> void:
	# Process states
	match current_state:
		State.IDLE: _process_idle()
		State.CHASING: _process_chasing()
		State.ATTACKING: _process_attacking()

	# Transition states
	if global_position.distance_to(player.global_position) <= attack_distance:
		current_state = State.ATTACKING
	elif global_position.distance_to(player.global_position) >= attack_distance:
		current_state = State.CHASING
	else:
		current_state = State.IDLE

	# Debug state
	state_label.text = _print_state(current_state)

	move_and_slide()


func _print_state(state: int) -> String:
	match state:
		State.IDLE: return "idle"
		State.CHASING: return "chasing"
		State.ATTACKING: return "attacking" 
	return "man idk"


func _process_idle() -> void:
	if (velocity != Vector2.ZERO):
		velocity = Vector2.ZERO


func _process_chasing() -> void:
	var dir := (player.global_position - global_position)
	velocity = dir.normalized() * move_speed


func _process_attacking() -> void:
	velocity = Vector2.ZERO
