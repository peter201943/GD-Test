

extends Node


var elapsed_time


func _ready():
	elapsed_time = 0


func _process(delta):
	_print_randoms_control(delta)


func _print_randoms_control(delta):
	elapsed_time += delta
	if elapsed_time >= 1:
		_print_randoms()
		elapsed_time = 0


func _print_randoms():
	print("RANDOMS")
	var chance = randi()%10+0
	var flotsom = chance / 10.0
	var flotsom2 = randi()%10+0 / 10.0
	print("randi()%10+0 = " + str(chance))
	print("randi()%10+0 / 10 = " + str(flotsom))
	print(" ")

