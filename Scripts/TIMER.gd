extends Label

var time

func _ready():
	time = 0.0
	_test_timer()

func _process(delta):
	time += delta
	self.text = str(time)

func _test_timer():
	print("TIMER: Called")
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	t.connect("timeout",self,"my_timeout")
	self.add_child(t)
	t.start()
	print("TIMER: Starting")
	yield(t,"timeout")
	t.queue_free()

func my_timeout():
	print("TIMER: I DID IT!!!")
