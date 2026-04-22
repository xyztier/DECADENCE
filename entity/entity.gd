class_name Entity extends CharacterBody2D


@export var health: float = 100.0
@export var attack_damage: float = 2.0


@onready var sprite: Sprite2D = $Sprite


func take_damage(amount: float) -> void:
	health -= amount
	if health <= 0:
		womp_womp()


# Death function
func womp_womp() -> void:
	set_physics_process(false)
	set_process(false)
	sprite.self_modulate.a = 0.3
