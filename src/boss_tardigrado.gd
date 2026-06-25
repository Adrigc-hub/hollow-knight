# Boss: El Tardígrado - estructura básica
extends Node2D

@export var max_hp := 100
@export var phase_two_threshold := 50

var hp := max_hp
var phase := 1

func _ready():
    hp = max_hp

func take_damage(amount: int, damage_type: String = "physical"):
    hp -= amount
    $HealthBar.value = hp
    print("Boss HP:", hp)
    if hp <= 0:
        die()
    elif hp <= phase_two_threshold and phase == 1:
        enter_phase_two()

func enter_phase_two():
    phase = 2
    print("El Tardígrado entra en fase 2")
    # change attack patterns, speed, visuals

func die():
    print("El Tardígrado derrotado")
    queue_free()

# Example: vulnerability check (player must have essence to damage or extra effect)
func is_vulnerable_to_essence(essence: String) -> bool:
    # Example: vulnerable to "fire" for extra damage
    return essence == "fire"
