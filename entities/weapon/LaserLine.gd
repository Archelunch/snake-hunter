extends RayCast2D

var is_casting = false : set = set_is_casting
var damage : int = 1

var enemies_list = []

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

func init(init_damage):
	damage = init_damage

func _physics_process(delta):
	var cast_point := target_position
	force_raycast_update()
	$ImpactParticle.emitting = is_colliding()
	if is_colliding():
		var body = get_collider()
		if body.is_in_group("mobs"):
			body.damage(damage)
			add_exception_rid(get_collider_rid())
		#cast_point = to_local(get_collision_point())
		$ImpactParticle.global_rotation = get_collision_normal().angle()
		$ImpactParticle.position = cast_point
	$Line2D.points[1] = cast_point
	$BeamParticle.position = cast_point*0.3
	$BeamParticle.process_material.emission_box_extents.x = cast_point.length()*0.5

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	$BeamParticle.emitting = is_casting
	$CastingParticle.emitting = is_casting
	if is_casting:
		appear()
		$Timer.start()
	else:
		$ImpactParticle.emitting = false
		disappear()
	set_physics_process(is_casting)

func appear():
	var tween = create_tween()
	$Line2D.width = 0.0
	tween.tween_property($Line2D, "width", 30.0, 0.2)
	
func disappear():
	var tween = create_tween()
	$Line2D.width = 30.0
	tween.tween_property($Line2D, "width", 0.0, 0.2)


func _on_timer_timeout():
	queue_free()
