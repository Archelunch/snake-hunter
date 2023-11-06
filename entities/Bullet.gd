extends Area2D

@export var ShotVFX : PackedScene
@export var speed = 2000
@export var damage : int = 5

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("mobs"):
		var shot_vfx = ShotVFX.instantiate()
		get_parent().add_child(shot_vfx)
		shot_vfx.transform = body.global_transform
		shot_vfx.scale = Vector2(0.2,0.2)
		body.damage(damage)
		queue_free()
