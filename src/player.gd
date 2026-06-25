# Player controller 2D - Godot 4 (GDScript)
extends CharacterBody2D

@export var speed := 220.0
@export var jump_velocity := -420.0
@export var gravity := 1000.0
@export var dash_speed := 600.0
@export var dash_time := 0.18

var velocity := Vector2.ZERO
var facing := 1
var can_double_jump := false
var has_double_jump := false
var is_dashing := false
var dash_timer := 0.0

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
    if not is_dashing:
        var move := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
        velocity.x = move * speed
        if move != 0:
            facing = sign(move)
        # gravedad
        if not is_on_floor():
            velocity.y += gravity * delta
        else:
            has_double_jump = can_double_jump
    else:
        dash_timer -= delta
        if dash_timer <= 0:
            is_dashing = false

    # salto
    if Input.is_action_just_pressed("jump"):
        if is_on_floor():
            velocity.y = jump_velocity
        elif has_double_jump:
            velocity.y = jump_velocity
            has_double_jump = false

    # dash
    if Input.is_action_just_pressed("dash") and not is_dashing:
        is_dashing = true
        dash_timer = dash_time
        velocity = Vector2(dash_speed * facing, 0)

    velocity = move_and_slide(velocity, Vector2.UP)

    # hooks de animación (si existe AnimatedSprite2D llamado "Anim")
    if $Anim:
        if is_dashing:
            $Anim.play("dash")
        elif not is_on_floor():
            $Anim.play("jump")
        elif abs(velocity.x) > 10:
            $Anim.play("run")
        else:
            $Anim.play("idle")
        $Anim.flip_h = facing < 0

# Función para aplicar una "esencia" (fire/shadow/joy)
func apply_essence(key: String):
    # Hook para cambiar comportamiento según esencia
    match key:
        "fire": print("Esencia: fuego activada")
        "shadow": print("Esencia: sombras activada")
        "joy": print("Esencia: alegria activada")
        _:
            print("Esencia desconocida: ", key)
