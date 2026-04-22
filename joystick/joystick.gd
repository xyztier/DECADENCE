class_name Joystick extends Node2D


const STICK_CLAMP: float = 100.0


@export var click_area: float = 348.0


var bounds: PackedVector2Array = PackedVector2Array([
	Vector2(-click_area, -click_area), # Top left
	Vector2(click_area, click_area), # Bottom right
])

var default_pos: Vector2 = Vector2.ZERO
var dir: Vector2 = Vector2.ZERO
var dragging: bool = false


@onready var base: Sprite2D = $Base
@onready var stick: Marker2D = $Stick


func _ready() -> void:
	default_pos = global_position


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed():
			if _in_click_area(event.position):
				dragging = true
				_reposition_joystick(event.position, event.is_pressed())
				_move_joystick(event.position)
		else:
			dragging = false
			_reposition_joystick(event.position, event.is_pressed())
			_release_joystick()
	elif event is InputEventScreenDrag:
		if dragging:
			_move_joystick(event.position)


func _move_joystick(pos: Vector2) -> void:
	stick.global_position = pos
	dir = stick.global_position - global_position

	# Visual
	stick.global_position = stick.global_position.clamp(
		to_global(Vector2(-STICK_CLAMP, -STICK_CLAMP)),
		to_global(Vector2(STICK_CLAMP, STICK_CLAMP))
	)


func _reposition_joystick(pos: Vector2, pressed: bool) -> void:
	if pressed:
		global_position = pos
	else:
		global_position = default_pos


func _release_joystick() -> void:
	# Cool animation
	var tween := get_tree().create_tween()
	tween.tween_property(
		stick,
		"global_position",
		global_position,
		0.1
	).set_ease(
		Tween.EASE_OUT).set_trans(
			Tween.TRANS_EXPO)


func _in_click_area(pos: Vector2) -> bool:
	pos = to_local(pos)
	return (
		(pos.x >= bounds[0].x && pos.y >= bounds[0].y) &&
		(pos.x <= bounds[1].x && pos.y <= bounds[1].y)
	)
