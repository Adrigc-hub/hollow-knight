# Gate that blocks a path until condition is met (e.g., has ability)
extends Node2D

@export var required_ability := "" # string key, e.g., "double_jump"
@onready var collider := $CollisionShape2D

func _ready():
    add_to_group("gates")
    update_state()

func update_state():
    var unlocked := Global.has_ability(required_ability)
    if collider:
        collider.disabled = unlocked
    visible = not unlocked
