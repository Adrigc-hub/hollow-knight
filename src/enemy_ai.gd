# Enemy AI - simple state machine: patrol, chase, attack
extends CharacterBody2D

@export var speed := 80.0
@export var chase_speed := 120.0
@export var detection_range := 180.0
@export var attack_range := 24.0
@export var max_health := 5

var origin := Vector2.ZERO
var dir := 1
var state := "patrol"
var player_ref := null
var health := max_health

func _ready():
    origin = global_position
    health = max_health

func _physics_process(delta):
    # find player if exists
    if player_ref == null:
        var players = get_tree().get_nodes_in_group("player")
        if players.size() > 0:
            player_ref = players[0]

    # simple state transitions
    if player_ref:
        var dist = global_position.distance_to(player_ref.global_position)
        if dist < attack_range:
            state = "attack"
        elif dist < detection_range:
            state = "chase"
        else:
            state = "patrol"

    match state:
        "patrol":
            velocity.x = dir * speed
            velocity = move_and_slide(velocity, Vector2.UP)
            if abs(global_position.x - origin.x) > 120:
                dir *= -1
        "chase":
            var sign_dir = sign(player_ref.global_position.x - global_position.x)
            velocity.x = sign_dir * chase_speed
            velocity = move_and_slide(velocity, Vector2.UP)
        "attack":
            # placeholder: stop and maybe trigger damage
            velocity.x = 0
            velocity = move_and_slide(velocity, Vector2.UP)

func take_damage(amount):
    health -= amount
    if health <= 0:
        queue_free()
