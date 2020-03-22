extends Label

var time

func _ready():
	time = 0.0

func _process(delta):
	time += delta
	self.text = str(time)
