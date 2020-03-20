extends KinematicBody

func _ready():
	test_print()

func test_print():
	print("Hello (print)")
	print_debug("Hello (debug)")
	printerr("Hello (err)")
	printraw("Hello (raw)")
