class_name Meditate extends CodeBlock

func run(me : Program, _other : Program) -> void:
	await animate(me, "mana")
	me.mana += 1


func get_code() -> String:
	return \
"""# meditate
mana += 1
"""
