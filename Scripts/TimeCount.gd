extends Label

var time

func _ready():
	time = 0.0

func _process(delta):
	time += delta
	var time_str = str(time)
	if time < 10:
		time_str = "0" + time_str
	else:
		time = 0.0
	if len(time_str) <= 3:
		time_str += "00"
	elif len(time_str) <= 4:
		time_str += "0"
	if len(time_str) > 5:
		time_str = time_str[0] + time_str[1] + time_str[2] + time_str[3] + time_str[4]
	self.set_text(time_str)
