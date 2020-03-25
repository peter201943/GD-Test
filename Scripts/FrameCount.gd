extends Label

func _process(delta):
	var dots = ""
	for i in randi()%3+1:
		dots += "."
	self.set_text(str(Engine.get_frames_per_second()) + dots)
