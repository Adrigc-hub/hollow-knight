# Global singleton (Autoload) - store abilities, checkpoint & simple save
# Godot 4 version
extends Node

var abilities := {}
var save_path := "user://hollow_knight_save.dat"
var checkpoint_position := Vector2.ZERO

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
	var data := {
		"abilities": abilities,
		"checkpoint": checkpoint_position
	}
	var json_string = JSON.stringify(data)
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)

func load_game():
	if ResourceLoader.exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:
			var json_string = file.get_as_text()
			var json = JSON.new()
			json.parse(json_string)
			var data = json.get_data()
			if data:
				abilities = data.get("abilities", {})
				checkpoint_position = data.get("checkpoint", Vector2.ZERO)
			else:
				abilities = {}
				checkpoint_position = Vector2.ZERO
	else:
		abilities = {}
		checkpoint_position = Vector2.ZERO
