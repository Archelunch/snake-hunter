extends CharacterBody2D

@export var movement_component: GodotParadiseTopDownMovement
@export var health_component: GodotParadiseHealthComponent

const SPEED = 300.0

func _ready():
	pass

func _process(delta):
	if health_component.check_is_dead():
		queue_free()

func damage(amount: int):
	health_component.damage(amount)
