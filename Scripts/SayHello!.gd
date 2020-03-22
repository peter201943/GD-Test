extends Node

var running_time = 0
const max_time = 1
var ok = true

func _process(delta):
	if running_time < max_time:
		running_time += delta
		print("HI")
		_do_it(running_time)
	elif ok:
		ok = false
		print("BYE")

func _do_it(time):
	if time >= max_time:
		get_parent().get_node("SideMenu").get_node("Label").text = "YIP"
	elif time > 2 * max_time / 3:
		get_parent().get_node("SideMenu").get_node("Label").text = "YAP"
	elif time > max_time / 3:
		get_parent().get_node("SideMenu").get_node("Label").text = "YUP"
