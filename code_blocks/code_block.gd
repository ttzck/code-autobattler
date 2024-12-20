class_name CodeBlock extends RefCounted

var container : CodeBlockContainer

func run(_me : Program, _other : Program) -> void:
	pass


func get_code() -> String:
	return "# do nothing"


func attack(n, other):
	if n > 0:
		await animate(other, "hp")
		other.hp = max(0, other.hp - n)


func animate(target : Program, stat : String, backwards = false):
	var node = target.status.container.get_node(stat)
	var destination = node.global_position + node.size / 2
	var orb = preload("res://animation_orb.tscn").instantiate()
	orb.destination = destination
	orb.global_position = container.global_position + container.size / 2
	if backwards:
		var temp = orb.destination
		orb.destination = orb.global_position
		orb.global_position = temp
	container.get_tree().root.add_child(orb)
	await orb.arrived
