extends Label

var time

func _ready():
	time = 0.0

func _process(delta):
	time += delta
	var time_str = str(time)
	if len(time_str) < 4:
		time_str += "0"
	elif len(time_str) < 3:
		time_str += "00"
	self.set_text(time_str)
