extends Node2D
class_name WeaponComponent

enum weapon_type {HIT_SCAN, PROJECTILE}

@export var damage: int = 50
@export var speed_type: weapon_type
@export var projectile_speed: int = 0
@export var magazine_size_max: int = 0
@export var reload_time: float = 0.0

@export var Bullet : PackedScene
@export var SpawnVFX : PackedScene

@export var timer : Timer

var magazine_size
# Called when the node enters the scene tree for the first time.
func _ready():
	magazine_size = magazine_size_max
	timer.one_shot = true
	timer.timeout.connect(_on_reload_finished)

func shoot():
	if timer.time_left != 0:
		pass
	elif magazine_size == 0:
		reload()
	else:
		shoot_process()
		magazine_size -= 1

func shoot_process():
	pass

func reload():
	if timer.time_left == 0 and magazine_size != magazine_size_max:
		timer.start(reload_time)
		
func _on_reload_finished():
	magazine_size = magazine_size_max
