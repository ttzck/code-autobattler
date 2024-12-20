class_name Training extends CodeBlock

func run(me : Program, _other : Program) -> void:
	await animate(me, "strength")
	me.strength += 3
	await animate(me, "sleep")
	me.sleep += 1


func get_code() -> String:
	return \
"""# training
strength += 3
sleep += 1"""
