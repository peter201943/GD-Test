extends Panel

var time = 0

func _process(delta):
	time += delta
	if time > 10:
		self.queue_free()
