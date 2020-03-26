extends Panel

# https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html

signal orange_signal
var fired = false
var time = 0
const limit = 2

func _process(delta):
	time += delta
	if time > limit and not fired:
		print("Sent Signal!")
		fired = true
		emit_signal("orange_signal")
