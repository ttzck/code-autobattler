class_name ThousandNeedles extends CodeBlock


func run(me : Program, other : Program) -> void:
	while me.mana > 0:
		me.mana -= 1
		await animate(me, "mana", true)
		await attack(1, other)


func get_code() -> String:
	return \
"""# thousand needles
while mana > 0:
	mana -= 1
	attack(1)"""
