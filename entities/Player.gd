extends CharacterBody2D


const SPEED = 300.0

@export var movement_component: GodotParadiseTopDownMovement
@export var health_component: GodotParadiseHealthComponent

@export var Bullet : PackedScene
@export var ShotVFX : PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("walk")

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_just_pressed("dash"):
		movement_component.dash()
	elif direction != Vector2.ZERO and !movement_component.is_dashing:
		movement_component.accelerate(direction, delta)
	elif !movement_component.is_dashing:
		movement_component.decelerate(delta)
	movement_component.move()
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	var shot_vfx = ShotVFX.instantiate()
	owner.add_child(shot_vfx)
	shot_vfx.transform = $Gunback.global_transform
	EventBus.publish("camera_shake", 0.45)
	
	
