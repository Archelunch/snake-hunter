extends WeaponComponent

@export var camera_shake: float = 0.45
@onready var muzzle = $Muzzle

func shoot_process():
	var b = Bullet.instantiate()
	add_child(b)
	b.global_transform = muzzle.global_transform
	b.set_is_casting(true)
	EventBus.publish("camera_shake", camera_shake)
