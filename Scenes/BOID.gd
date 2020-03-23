

class_name Boid
extends KinematicBody
# Boid moves and groups a collection of objects together
# Used to learn Godot's `Groups`
# https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_continued.html


const MAX_PEERS := 5
const PEER_RANGE := 10
const MOVE_SPEED := 5


var peers = []
var direction = Vector3(1,1,1)


func _ready() -> void:
	# Boid needs to find other boids (assume no more boids are dynamically added)
	add_to_group("boids")
	self._squawk()

func _process(delta) -> void:
	# Boid is updated every frame
	_boid_behavior()


func _boid_behavior() -> void:
	# Boid behavior is complex set of smaller behaviors
	_get_peers()
	_get_flock_direction()
	_set_direction()
	_swarm_squawk()

func _get_flock_direction() -> void:
	# For all the nearby boids, get their normal, and sum the normals to get this boid's new direction
	for boid in peers:
		direction += boid.direction

func _get_peers() -> void:
	pass

func _set_direction() -> void:
	# Moves the boid in the specified direction
	pass

func _swarm_squawk() -> void:
	# Randomly decides whether the swarm will squawk
	# Every 2 seconds, there is a 25% chance of squawking
	if randi()%222+1 == 2:
		get_tree().call_group("boids","_squawk")

func _squawk() -> void:
	# Any boid can request other boids to squawk (signal)
	print("Squawk!")
	get_node("BOID SQUAWK")._squawk()

