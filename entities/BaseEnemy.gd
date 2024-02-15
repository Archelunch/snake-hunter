extends CharacterBody2D

@export var movement_component: GodotParadiseTopDownMovement
@export var health_component: GodotParadiseHealthComponent

func _ready():
	pass

func damage(amount: int):
	health_component.damage(amount)

func _physics_process(delta):
	var target_player = get_parent().get_node("Player")
	position += (target_player.position - position).normalized() * 0.7

func _on_died():
	queue_free()
