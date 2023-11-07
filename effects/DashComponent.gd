extends Node2D
class_name DashComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	ghosting()

func set_property(tx_pos, node_scale, tx_scale, node_rotation, tx_rotation, texture):
	position = tx_pos
	scale = node_scale
	rotation = node_rotation
	$Sprite2D.scale = tx_scale
	$Sprite2D.rotation = tx_rotation
	$Sprite2D.texture = texture
	
func ghosting():
	var tween_fade = get_tree().create_tween()
	tween_fade.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.75)
	await tween_fade.finished
	queue_free()
