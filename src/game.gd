# Global singleton (Autoload) - store abilities, checkpoint & simple save
extends Node

var abilities := {}
var save_path := "user://save.dat"
var checkpoint_position := null

func _ready():
    load_game()

func give_ability(key: String):
    abilities[key] = true
    save_game()
    # notify scenes
    get_tree().call_group("gates", "update_state")

func has_ability(key: String) -> bool:
    return abilities.get(key, false)

func set_checkpoint_position(pos: Vector2):
    checkpoint_position = pos
    save_game()

func get_checkpoint_position() -> Vector2:
    if checkpoint_position:
        return checkpoint_position
    return Vector2.ZERO

func save_game():
    var file := File.new()
    file.open(save_path, File.WRITE)
    var data := {
        "abilities": abilities,
        "checkpoint": checkpoint_position
    }
    file.store_var(data)
    file.close()

func load_game():
    var file := File.new()
    if file.file_exists(save_path):
        file.open(save_path, File.READ)
        var data = file.get_var()
        file.close()
        abilities = data.get("abilities", {})
        checkpoint_position = data.get("checkpoint", null)
    else:
        abilities = {}
        checkpoint_position = null
