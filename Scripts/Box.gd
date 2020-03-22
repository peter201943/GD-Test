



### DECLARATIONS ###
class_name SimpleTest
extends KinematicBody
# Just a simple script to get familiars with GDScript




### REFERENCES ###
# [Make Your First 2D Game with Godot: Player and Enemy (beginner tutorial part 1)](https://www.youtube.com/watch?v=Mc13Z2gboEk)




### VALUES ###
const FORCE_DOWN := -0.8					# How fast we Fall
var current_direction := Vector3(1,1,1)		# Current Speed
export var max_speed := 0.5					# How fast we can move




### BUILT-INS ###
func _ready():
	_test_print()


func _physics_process(delta: float) -> void:
	_move_box(delta)
	_check_speed()




### PRIVATE METHODS ###
func _move_box(delta: float) -> void:
	# Tests the Slipping and Sliding of an Object
	current_direction = self.move_and_slide(current_direction)
	current_direction.y += FORCE_DOWN * delta
	current_direction.x -= FORCE_DOWN * delta
	current_direction.z -= FORCE_DOWN * delta


func _test_print():
	# Tests the Printing of some stuff
	print("Hello (print)")
	print_debug("Hello (debug)")
	printerr("Hello (err)")
	printraw("Hello (raw)")

	
func _check_speed():
	# Resets speed if over a certain value
	if ((current_direction.x > max_speed) or (current_direction.y > max_speed) or (current_direction.z > max_speed)):
		current_direction.x = 0
		current_direction.y = 0
		current_direction.z = 0



