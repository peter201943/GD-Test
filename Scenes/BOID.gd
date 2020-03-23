



class_name Boid
extends KinematicBody
# Boid moves and groups a collection of objects together
# Used to learn Godot's `Groups`
# https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_continued.html




const MAX_PEERS := 5
const PEER_RANGE := 0.5
const MOVE_SPEED := 0.5
const SQUAWK_MODE := "_peer_squawk"




var peers = []
var direction = Vector3(1,1,1)
var squawk_timer = Timer.new()




func _ready() -> void:
	# Boid needs to find other boids (assume no more boids are dynamically added)
	squawk_timer.set_wait_time(0.1)
	squawk_timer.set_one_shot(true)
	squawk_timer.connect("timeout",self,SQUAWK_MODE)
	self.add_child(squawk_timer)
	add_to_group("boids")
	self._squawk()


func _process(delta) -> void:
	# Boid is updated every frame
	_boid_comm_behavior()


func _physics_process(delta):
	# Boid Distances/Groups updated every physics frame
	_boid_phys_behavior()




func _boid_phys_behavior() -> void:
		# Boid physics behavior is also a complex set
		_get_peers()
		_get_flock_direction()
		_set_direction()


func _boid_comm_behavior() -> void:
	# Boid behavior is complex set of smaller behaviors
	_random_squawk()


func _get_flock_direction() -> void:
	# For all the nearby boids, get their normal, and sum the normals to get this boid's new direction
	direction = Vector3(0,0,0)
	for boid in peers:
		direction += boid.direction
	direction = direction.normalized()
	direction.x = direction.x * MOVE_SPEED
	direction.y = direction.y * MOVE_SPEED
	direction.z = direction.z * MOVE_SPEED


func _get_peers() -> void:
	# Find all nearby boids/refresh
	peers = []
	var temp_peers = get_tree().get_nodes_in_group("boids")
	for boid in temp_peers:
		if (Vector3(self.translation - boid.translation).length() < PEER_RANGE):
			peers.append(boid)
	#print("PEERS: " + str(len(peers)))


func _set_direction() -> void:
	# Moves the boid in the specified direction
	# Also rotates the body
	direction = self.move_and_slide(direction)


func _random_squawk() -> void:
	# Randomly decides whether the swarm will squawk
	# Every 2 seconds, there is a 25% chance of squawking -- at least, I tried -- not true anymore, btw
	if randi()%222+1 == 2:
		self._squawk()
		squawk_timer.start()
		yield(squawk_timer, "timeout")
		

func _swarm_squawk():
	# Makes the rest of the swarm squawk in response
	print(" ")
	get_tree().call_group("boids","_squawk")


func _peer_squawk():
	# Only the nearby boids squawk in response
	print(" ")
	for boid in peers:
		boid._squawk()


func _squawk() -> void:
	# Any boid can request other boids to squawk (signal)
	print("Squawk!")
	get_node("BOID SQUAWK")._squawk()



