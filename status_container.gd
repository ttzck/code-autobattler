class_name StatusContainer extends PanelContainer

@onready var container = $MarginContainer/VBoxContainer

var cache := {}
var timers := {}
var program : Program
var _delta

func _process(delta : float):
	_delta = delta
	_display("hp")
	_display("strength")
	_display("mana")
	_display("sleep")


func _display(key):
	var value = program.get(key)
	var old_value = cache[key] if cache.has(key) else 0
	if not timers.has(key): timers[key] = 0
	if value != old_value: timers[key] = 0.25
	cache[key] = value
	timers[key] -= _delta
	
	var color = "[color=gray][shake rate=0.0 level=0 connected=0]"
	if timers[key] > 0:
		color = "[color=white][shake rate=40.0 level=15 connected=0]"
	container.get_node(key).text = "[fill]" + key + ": " + color  + str(value) + "[/shake][/color][/fill]"
