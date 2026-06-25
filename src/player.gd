# Player controller 2D - Ampliado para Godot 4
# Incluye: movimiento, dash, doble salto desbloqueable, wall-cling, wall-jump, ataque cargado, esencias
extends CharacterBody2D

@export var speed := 220.0
@export var jump_velocity := -420.0
@export var gravity := 1200.0
@export var dash_speed := 650.0
@export var dash_time := 0.14
@export var wall_slide_speed := 50.0
@export var charge_time := 0.8 # segundos para carga completa
@export var base_damage := 1

var velocity := Vector2.ZERO
var facing := 1
var can_double_jump := false
var has_double_jump := false
var is_dashing := false
var dash_timer := 0.0

var on_wall := false
var is_wall_sliding := false
var wall_dir := 0

var charging := false
var charge_timer := 0.0

var current_essence := "none" # "fire", "shadow", "joy"

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
    var move := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

    # Horizontal movement (locked during dash)
    if not is_dashing:
        velocity.x = lerp(velocity.x, move * speed, 0.2)
        if move != 0:
            facing = sign(move)

    # Gravity
    if not is_on_floor() and not is_wall_sliding:
        velocity.y += gravity * delta

    # Wall detection (simple raycast using is_on_wall)
    on_wall = is_on_wall()
    wall_dir = get_wall_direction()

    # Wall slide
    if on_wall and not is_on_floor() and velocity.y > 0:
        is_wall_sliding = true
        velocity.y = min(velocity.y, wall_slide_speed)
    else:
        is_wall_sliding = false

    # Jump
    if Input.is_action_just_pressed("jump"):
        if is_on_floor():
            velocity.y = jump_velocity
        elif is_wall_sliding:
            # wall jump away from wall
            velocity.y = jump_velocity
            velocity.x = -wall_dir * speed * 0.9
            is_wall_sliding = false
            has_double_jump = can_double_jump
        elif has_double_jump:
            velocity.y = jump_velocity
            has_double_jump = false

    # Dash
    if Input.is_action_just_pressed("dash") and not is_dashing and Global.has_ability("dash"):
        is_dashing = true
        dash_timer = dash_time
        velocity = Vector2(dash_speed * facing, 0)

    if is_dashing:
        dash_timer -= delta
        if dash_timer <= 0:
            is_dashing = false

    # Charged attack (hold attack to charge)
    if Input.is_action_pressed("attack"):
        if not charging:
            charging = true
            charge_timer = 0.0
        else:
            charge_timer += delta
    elif Input.is_action_just_released("attack") and charging:
        perform_attack(charge_timer)
        charging = false
        charge_timer = 0.0

    # Debug: change essence with "essence_next" (you can map a key for debugging)
    if Input.is_action_just_pressed("essence_next"):
        cycle_essence()

    velocity = move_and_slide(velocity, Vector2.UP)

    # animations (if AnimatedSprite2D exists)
    if $Anim:
        if is_dashing:
            $Anim.play("dash")
        elif is_wall_sliding:
            $Anim.play("wall_slide")
        elif not is_on_floor():
            $Anim.play("jump")
        elif abs(velocity.x) > 10:
            $Anim.play("run")
        else:
            $Anim.play("idle")
        $Anim.flip_h = facing < 0

func perform_attack(charge_amount: float):
    var power := 1.0
    if charge_amount >= charge_time:
        power = 2.5
    elif charge_amount > 0.25:
        power = 1.5

    var damage := int(base_damage * power)
    # Modify damage based on essence
    match current_essence:
        "fire": damage += 1
        "shadow": damage += 0
        "joy": damage += 0
        _:
            pass

    # This is a placeholder: implement area detection / hitboxes
    print("Attack with damage:", damage, "essence:", current_essence)

func apply_essence(key: String):
    current_essence = key
    # Hook to change visuals/effects
    print("Esencia aplicada:", key)

func cycle_essence():
    var list = ["none", "fire", "shadow", "joy"]
    var i = list.find(current_essence)
    i = (i + 1) % list.size()
    apply_essence(list[i])

func get_wall_direction() -> int:
    # returns -1 if wall on left, 1 if wall on right, 0 none
    if is_on_wall():
        # use a short raycast to check which side (simple method)
        var left_point = global_position + Vector2(-8, 0)
        var right_point = global_position + Vector2(8, 0)
        var space = get_world_2d().direct_space_state
        var left_hit = space.intersect_point(left_point, 1, [], 0x7FFFFFFF, true, true)
        var right_hit = space.intersect_point(right_point, 1, [], 0x7FFFFFFF, true, true)
        if left_hit.size() > 0:
            return -1
        if right_hit.size() > 0:
            return 1
    return 0

# Hooks para ser llamado por pickups
func unlock_double_jump():
    can_double_jump = true
    has_double_jump = true
    Global.give_ability("double_jump")

func unlock_wall_grab():
    Global.give_ability("wall_grab")

func unlock_dash():
    Global.give_ability("dash")
