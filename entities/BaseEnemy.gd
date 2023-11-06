extends CharacterBody2D

@export var movement_component: GodotParadiseTopDownMovement
@export var health_component: GodotParadiseHealthComponent

func _ready():
	pass

func damage(amount: int):
	health_component.damage(amount)

func _on_died():
	queue_free()
