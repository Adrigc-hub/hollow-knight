# Global singleton (Autoload) - store abilities & simple save
extends Node

var abilities := {}
var save_path := "user://save.dat"

func _ready():
    load_game()

func give_ability(key: String):
    abilities[key] = true
    save_game()
    # notify scenes
    get_tree().call_group("gates", "update_state")

func has_ability(key: String) -> bool:
    return abilities.get(key, false)

func save_game():
    var file := File.new()
    file.open(save_path, File.WRITE)
    file.store_var(abilities)
    file.close()

func load_game():
    var file := File.new()
    if file.file_exists(save_path):
        file.open(save_path, File.READ)
        abilities = file.get_var()
        file.close()
    else:
        abilities = {}
