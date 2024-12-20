class_name ThreadContainer extends PanelContainer

@onready var container := $MarginContainer/VBoxContainer

var program : Program

var thread_size : int:
	get: return container.get_child_count()
var max_thread_size = 8


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is CodeBlockContainer and thread_size < max_thread_size


func _drop_data(at_position: Vector2, data: Variant) -> void:
	var i = 0
	for child in container.get_children():
		if at_position.y > child.offset_bottom:
			i += 1
	data.reparent(container)
	container.move_child(data, i)


func get_code_block(i : int) -> CodeBlock:
	if i < thread_size:
		return container.get_child(i).content
	return null


func add_code_block(code_block, disable_drag = false) -> void:
	container.add_child(CodeBlockContainer.new(code_block, true, disable_drag))


func get_code_block_container(i : int) -> CodeBlockContainer:
	return container.get_child(i)
	
func clear():
	for child in container.get_children():
		child.queue_free()
