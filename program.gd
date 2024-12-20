class_name Program extends RefCounted

var is_player = false

# stats
var hp := 0
var i := 0
var strength := 0
var mana := 0
var sleep := 0

var thread : ThreadContainer
var status : StatusContainer


func _init(_thread : ThreadContainer, _status : StatusContainer):
	thread = _thread
	thread.program = self
	status = _status
	status.program = self


func step(other):
	if sleep > 0:
		sleep -= 1
	else:
		var code = thread.get_code_block(i)
		if code != null:
			await code.run(self, other)
		i += 1
		if i >= thread.thread_size:
			i = 0
			sleep += max(0, thread.max_thread_size - thread.thread_size)


func reset_stats():
	hp = 10
	i = 0
	strength = 0
	mana = 0
	sleep = 0
