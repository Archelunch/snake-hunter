extends WeaponComponent

@export var camera_shake: float = 0.55
@export var bullet_life_time: float = 0.1

func shoot_process():
	for muzzle in $Muzzles.get_children():
		var b = Bullet.instantiate()
		get_tree().root.add_child(b)
		b.init(damage, projectile_speed, bullet_life_time)
		b.transform = muzzle.global_transform
	var shot_vfx = SpawnVFX.instantiate()
	get_tree().root.add_child(shot_vfx)
	shot_vfx.transform = $Gunback.global_transform
	EventBus.publish("camera_shake", camera_shake)
