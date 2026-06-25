# Boss: El Tardígrado - patterns: pulse (projectiles) and stomps
extends Node2D

@export var max_hp := 100
@export var phase_two_threshold := 50
@export var pulse_interval := 2.0
@export var pulse_speed := 220.0

var hp := max_hp
var phase := 1
var pulse_timer := 0.0

func _ready():
    hp = max_hp
    pulse_timer = pulse_interval

func _process(delta):
    pulse_timer -= delta
    if pulse_timer <= 0:
        pulse()
        pulse_timer = pulse_interval

func pulse():
    # Simple radial pulse: spawn small projectiles that move outward
    # Placeholder: just print. Implement spawn as Area2D scenes for real projectiles.
    print("Tardígrado: pulse! (fase ", phase, ")")

func take_damage(amount: int, damage_type: String = "physical"):
    var actual_damage = amount
    # Vulnerability: if player uses fire essence, take +50% damage
    # We'll check damage_type == "essence_fire" for extra effect
    if damage_type == "essence_fire":
        actual_damage = int(amount * 1.5)

    hp -= actual_damage
    if $HealthBar:
        $HealthBar.value = hp
    print("Boss HP:", hp, "(-", actual_damage, ")")
    if hp <= 0:
        die()
    elif hp <= phase_two_threshold and phase == 1:
        enter_phase_two()

func enter_phase_two():
    phase = 2
    pulse_interval = max(0.6, pulse_interval * 0.6)
    print("El Tardígrado entra en fase 2: pulse_interval=", pulse_interval)

func die():
    print("El Tardígrado derrotado")
    queue_free()

func is_vulnerable_to_essence(essence: String) -> bool:
    return essence == "fire"
