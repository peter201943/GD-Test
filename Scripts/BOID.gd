



class_name Boid
extends KinematicBody
# Boid moves and groups a collection of objects together
# Used to learn Godot's `Groups`
# https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_continued.html




const MAX_PEERS := 3
const PEER_RANGE := 0.5
const MOVE_SPEED := 20
const ANGLE_SMOOTH := 0.02
const SQUAWK_MODE := "_peer_squawk"
const SPEED_CUTOFF := 2
const SPEED_WAIT := 0.1
const MAX_AGE := 3
const SPAWN_SIZE := 2
const SPAWN_TIME := 2.5
const SPAWN_CHANCE := 0.2




var peers = []
var direction = Vector3(1,1,1)
var squawk_timer = Timer.new()
var current_speed = 0
var last_position = 0
var speed_time = 0
export (int) var age
var spawned = false
var boid_scene = null





func _ready() -> void:
	# Boid needs to find other boids (assume no more boids are dynamically added)
	squawk_timer.set_wait_time(0.1)
	squawk_timer.set_one_shot(true)
	squawk_timer.connect("timeout",self,SQUAWK_MODE)
	self.add_child(squawk_timer)
	add_to_group("boids")
	self._squawk()
	last_position = self.translation
	boid_scene = load("res://Scenes/Boid.tscn")
	randomize()


func _process(delta) -> void:
	# Boid is updated every frame
	_boid_comm_behavior()


func _physics_process(delta: float) -> void:
	# Boid Distances/Groups updated every physics frame
	_boid_phys_behavior(delta)




func _boid_phys_behavior(delta: float) -> void:
		# Boid physics behavior is also a complex set
		_get_peers()
		_get_flock_direction()
		_set_direction()
		_get_speed(delta)
		_unstuck()
		_get_age(delta)


func _boid_comm_behavior() -> void:
	# Boid behavior is complex set of smaller behaviors
	_random_squawk()
	_age()
	_spawn()


func _get_flock_direction() -> void:
	# For all the nearby boids, get their normal, and sum the normals to get this boid's new direction
	direction = Vector3(0,0,0)
	for boid in peers:
		direction += boid.rotation_degrees
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
			if len(peers) >= MAX_PEERS:
				return
	#print("PEERS: " + str(len(peers)))


func _set_direction() -> void:
	# Moves the boid in the specified direction
	# Also rotates the body
	direction = self.move_and_slide(direction)
	self.rotate(Vector3(1,0,0), self.direction.x * ANGLE_SMOOTH)
	self.rotate(Vector3(0,1,0), self.direction.y * ANGLE_SMOOTH)
	self.rotate(Vector3(0,0,1), self.direction.z * ANGLE_SMOOTH)


func _random_squawk() -> void:
	# Randomly decides whether the swarm will squawk
	# Every 2 seconds, there is a 25% chance of squawking -- at least, I tried -- not true anymore, btw
	if randi()%222+1 == 2:
		self._squawk()
		squawk_timer.start()
		yield(squawk_timer, "timeout")


func _swarm_squawk():
	# Makes the rest of the swarm squawk in response
	#print(" ")
	get_tree().call_group("boids","_squawk")


func _peer_squawk():
	# Only the nearby boids squawk in response
	#print(" ")
	for boid in peers:
		boid._squawk()


func _squawk() -> void:
	# Any boid can request other boids to squawk (signal)
	#print("Squawk!")
	get_node("BOID SQUAWK")._squawk()


func _unstuck():
	# Scrambles the boids to face a new direction if they aren't moving
	if current_speed < SPEED_CUTOFF:
		self.rotate(Vector3(1,0,0), randf()*0.8+(-0.8))
		self.rotate(Vector3(0,1,0), randf()*0.8+(-0.8))
		self.rotate(Vector3(0,0,1), randf()*0.8+(-0.8))


func _get_speed(delta: float):
	# Because Godot doesn't have a built in
	speed_time += delta
	if speed_time > SPEED_WAIT:
		speed_time = 0
		current_speed = 0
		current_speed += abs(self.translation[0] - last_position[0]) / delta
		current_speed += abs(self.translation[1] - last_position[1]) / delta
		current_speed += abs(self.translation[2] - last_position[2]) / delta
		last_position = self.translation
		#_sample_speed()


func _sample_speed():
	# Debug purposes. Shows the current speed
	print("CURR SPD " + str(current_speed))


func _age():
	# Kill this boid after lifetime exceeded
	if age > MAX_AGE:
		self.get_parent().remove_child(self)


func _spawn():
	# Spawn more boids
	if (age > SPAWN_TIME):
		var chance = randi()%10+1
		var percent_chance = chance / 10.0
		print("Try Spawn")
		print("CHANCE @" + str(chance))
		print("PERCENT @" + str(percent_chance))
		if (age < MAX_AGE) and (not spawned) and (percent_chance <= SPAWN_CHANCE):
			print("Yep\n")
			var new_boid = null
			for boids in SPAWN_SIZE:
				new_boid = boid_scene.instance()
				self.get_parent().add_child(new_boid)
			spawned = true
		else:
			print("Nope\n")


func _bad_spawn():
	# Spawn more boids (VERY VERY BAD -- put here as an example)
	var chance = randf()*0.9+0.09
	if (age > SPAWN_TIME) and (age < MAX_AGE) and (not spawned) and (chance < SPAWN_CHANCE):
		print("Spawning" + str(chance))
		var new_boid = null
		for boids in SPAWN_SIZE:
			new_boid = boid_scene.instance()
			self.get_parent().add_child(new_boid)
		spawned = true


func _get_age(delta: float):
	# Updates the age of this boid
	age += delta





