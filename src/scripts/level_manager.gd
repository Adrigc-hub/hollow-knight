extends Node2D

# Level manager that spawns a few axolotls in the garden
var axolotl_scene := preload("res://src/scenes/Axolotl.tscn")
var positions := [Vector2(380, 220), Vector2(520, 220), Vector2(660, 220)]

func _ready() -> void:
    for p in positions:
        var a = axolotl_scene.instantiate()
        a.position = p
        add_child(a)
