extends KinematicBody


# CONSTANTS
const move_velocity := Vector3(1,1,1)		# Allows moving of box around
const down_force := -0.8



# ENGINE
func _ready():
	test_print()

func _physics_process(delta: float) -> void:
	move_box(delta)




# MECHANICS
func move_box(delta: float) -> void:
	"""Tests the Slipping and Sliding of an Object"""
	self.move_and_slide(move_velocity)
	move_velocity.y += down_force * delta


func test_print():
	"""Tests the Printing of some stuff"""
	print("Hello (print)")
	print_debug("Hello (debug)")
	printerr("Hello (err)")
	printraw("Hello (raw)")

