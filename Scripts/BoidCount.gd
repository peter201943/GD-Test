extends Label

var boid_count = 0

func _process(_delta):
	_count_boids()
	_show_count()

func _count_boids():
	var boids = get_tree().get_nodes_in_group("boids")
	boid_count = 0
	for boid in boids:
		boid_count += 1

func _show_count():
	self.set_text(str(boid_count).pad_zeros(5))
	
