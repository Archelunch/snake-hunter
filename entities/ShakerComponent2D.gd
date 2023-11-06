extends Node2D
class_name ShakerComponent2D


@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.2  # Maximum rotation in radians (use sparingly).

@export var trauma : float = 0.0  # Current shake strength.
@export var trauma_power = 2  # Trauma exponent. Use [2, 3].
@export var camera : Camera2D


func _ready():
	randomize()
	EventBus.subscribe("camera_shake", self, "start_shaking")
	
func _process(delta):
	if trauma != 0.0:
		shake()

func start_shaking(value: float):
	var tween = create_tween()
	trauma = value
	tween.tween_property(self, "trauma", 0, decay).set_trans(Tween.TRANS_SINE)
	

func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	camera.offset.x = max_offset.x * amount * randf_range(-1, 1)
	camera.offset.y = max_offset.y * amount * randf_range(-1, 1)
