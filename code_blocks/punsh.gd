class_name Punsh extends CodeBlock

func run(me : Program, other : Program) -> void:
	await attack(me.strength, other)


func get_code() -> String:
	return \
"""# punsh
attack(strength)"""
