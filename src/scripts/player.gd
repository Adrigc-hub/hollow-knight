extends CharacterBody2D

# Player (Zorro) placeholder script with movement, jump, dash, attack, and HP

const GRAVITY = 1200.0
var speed := 180.0
var jump_velocity := -420.0
var dash_speed := 500.0
var dash_time := 0.12
var dash_cooldown := 0.6

var velocity := Vector2.ZERO
var facing := 1
var can_dash := true
var dashing := false
var dash_timer := 0.0
var dash_cooldown_timer := 0.0

var max_hp := 100
var hp := 100

signal attacked

func _ready():
    add_to_group("player")
    set_physics_process(true)
    update()

func _physics_process(delta: float) -> void:
    var input_dir := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

    if not dashing:
        velocity.x = input_dir * speed
        if input_dir != 0:
            facing = sign(input_dir)

    # Gravity
    if not is_on_floor():
        velocity.y += GRAVITY * delta

    # Jump (use ui_up or space if configured)
    if Input.is_action_just_pressed("ui_up") and is_on_floor():
        velocity.y = jump_velocity

    # Dash
    if Input.is_action_just_pressed("ui_select") and can_dash:
        dashing = true
        can_dash = false
        dash_timer = dash_time
        velocity = Vector2(dash_speed * facing, 0)

    if dashing:
        dash_timer -= delta
        if dash_timer <= 0:
            dashing = false
            dash_cooldown_timer = dash_cooldown
    else:
        if dash_cooldown_timer > 0:
            dash_cooldown_timer -= delta
            if dash_cooldown_timer <= 0:
                can_dash = true

    # Attack
    if Input.is_action_just_pressed("ui_accept"):
        emit_signal("attacked")

    velocity = move_and_slide(velocity, Vector2.UP)

func heal(amount:int) -> void:
    hp = min(hp + amount, max_hp)
    print("Player healed to: %d" % hp)

func damage(amount:int) -> void:
    hp -= amount
    if hp <= 0:
        die()

func die() -> void:
    print("Player died (placeholder)")

func _draw() -> void:
    # Simple placeholder art: body rectangle and cloak like Hollow Knight style
    draw_rect(Rect2(Vector2(-10, -20), Vector2(20, 40)), Color8(50, 50, 60))
    draw_circle(Vector2(-4, -8), 2, Color(1,1,1))
    draw_circle(Vector2(4, -8), 2, Color(1,1,1))
    draw_line(Vector2(-10, -12), Vector2(10, 12), Color8(20,20,30), 4)

func _process(delta: float) -> void:
    update()
