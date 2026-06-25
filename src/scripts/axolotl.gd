extends Area2D

# Axolotl collectible/interactive placeholder
var heal_amount := 10

func _ready() -> void:
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body) -> void:
    if body is CharacterBody2D:
        if body.has_method("heal"):
            body.heal(heal_amount)
        queue_free()

func _draw() -> void:
    draw_circle(Vector2.ZERO, 10, Color8(140,200,180))
    draw_circle(Vector2(-3, -2), 2, Color(1,1,1))
    draw_circle(Vector2(3, -2), 2, Color(1,1,1))

func _process(delta: float) -> void:
    update()
