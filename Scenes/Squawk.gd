extends AudioStreamPlayer3D

func _squawk():
	var t = Timer.new()
	t.set_wait_time(randf()*0.5)
	t.set_one_shot(true)
	t.connect("timeout",self,"_real_squawk")
	self.add_child(t)
	t.start()
	yield(t,"timeout")
	t.queue_free()

func _real_squawk():
	play()
