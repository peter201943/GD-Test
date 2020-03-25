extends Panel

# https://godotengine.org/qa/1936/how-do-i-check-if-a-node-was-freed
# https://godotengine.org/qa/2773/detect-if-an-object-reference-is-freed

var pear_fruit
var time = 0

func _ready():
	pear_fruit = Panel.new()
	self.add_child(pear_fruit)
	pear_fruit.set_position(Vector2(0,0))
	pear_fruit.set_size(Vector2(200,200))
	print(pear_fruit)

func _process(delta):
	time += delta
	if time > 5 and is_instance_valid(pear_fruit):
		print(pear_fruit)
		pear_fruit.free()
