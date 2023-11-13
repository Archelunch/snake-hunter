extends WeaponComponent

@export var camera_shake: float = 0.45

func shoot_process():
	var b = Bullet.instantiate()
	print(damage, projectile_speed)
	get_tree().root.add_child(b)
	b.init(damage, projectile_speed)
	b.transform = $Muzzle.global_transform
	var shot_vfx = SpawnVFX.instantiate()
	get_tree().root.add_child(shot_vfx)
	shot_vfx.transform = $Gunback.global_transform
	EventBus.publish("camera_shake", camera_shake)
