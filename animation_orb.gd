extends Control

signal arrived

var destination : Vector2

func _process(delta: float) -> void:
	var dist = global_position.distance_to(destination)
	if dist < 0.1:
		arrived.emit()
		queue_free()
	else:
		global_position += global_position.direction_to(destination) * min(dist, delta * 1000.0)
