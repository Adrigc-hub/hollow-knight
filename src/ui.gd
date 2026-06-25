# UI manager - muestra esencia y habilidades
extends CanvasLayer

onready var essence_label := $EssenceLabel
onready var abilities_label := $AbilitiesLabel

func _ready():
    update_ui()

func update_ui():
    # player essence (if player exists)
    if get_tree().get_root().has_node("/root/Main/Player"):
        var player = get_tree().get_root().get_node("/root/Main/Player")
        essence_label.text = "Esencia: %s" % player.current_essence
    else:
        essence_label.text = "Esencia: (player no instanciado)"

    var keys = []
    for k in Global.abilities.keys():
        keys.append(k)
    abilities_label.text = "Abilities: %s" % ", ".join(keys)
