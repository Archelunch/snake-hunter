extends CharacterBody2D


const SPEED = 300.0

@export var movement_component: GodotParadiseTopDownMovement
@export var health_component: GodotParadiseHealthComponent

@export var Bullet : PackedScene
@export var ShotVFX : PackedScene
@export var DashVFX: PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.play("walk")

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2.ZERO and !movement_component.is_dashing:
		movement_component.accelerate(direction, delta)
	elif !movement_component.is_dashing:
		movement_component.decelerate(delta)
	movement_component.move()

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()
	if event.is_action_pressed("dash"):
		movement_component.dash()
		#dash()
	
func dash_effect():
	var current_texture = $AnimatedSprite2D.sprite_frames.get_frame_texture("walk", $AnimatedSprite2D.frame)
	var dash_vfx = DashVFX.instantiate()
	dash_vfx.set_property(position, scale, $AnimatedSprite2D.scale, rotation, $AnimatedSprite2D.rotation, current_texture)
	owner.add_child(dash_vfx)

func _on_timer_timeout():
	dash_effect()

func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform
	var shot_vfx = ShotVFX.instantiate()
	owner.add_child(shot_vfx)
	shot_vfx.transform = $Gunback.global_transform
	EventBus.publish("camera_shake", 0.45)

func _on_dashed(position):
	dash_effect()
	EventBus.publish("camera_shake", 0.2)
	$Timer.start()

func _on_finished_dash(initial_position, final_position):
	$Timer.stop()
	movement_component.decelerate(get_physics_process_delta_time(), false)

