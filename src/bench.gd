extends Area2D

@export var bench_name := "Bench"

func _ready():
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
    if body.is_in_group("player"):
        # Set the checkpoint to this bench's global position
        Global.set_checkpoint_position(global_position)
        Global.save_game()
        print("Bench: checkpoint guardado en:", global_position)
        # Optional: visual feedback or animation
