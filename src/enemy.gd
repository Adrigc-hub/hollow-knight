# Enemy simple behaviour
extends CharacterBody2D

@export var speed := 80.0
@export var patrol_distance := 120.0
@export var max_health := 3

var origin_x := 0.0
var dir := 1
var health := max_health

func _ready():
    origin_x = global_position.x
    health = max_health

func _physics_process(delta):
    velocity.x = dir * speed
    velocity = move_and_slide(velocity, Vector2.UP)

    if abs(global_position.x - origin_x) > patrol_distance:
        dir *= -1

func take_damage(amount):
    health -= amount
    if health <= 0:
        queue_free()
