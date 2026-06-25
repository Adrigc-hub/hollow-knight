extends Area2D

@export var ability_key := "dash"
@export var pickup_name := "Pickup"

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    # Check if the body is the player (grouped as "player")
    if body.is_in_group("player"):
        if ability_key != "":
            Global.give_ability(ability_key)
            print("Pickup: concedida ability:", ability_key)
        queue_free()
