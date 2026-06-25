# UI manager - muestra esencia, habilidades y vida
extends CanvasLayer

onready var essence_label := $EssenceLabel
onready var abilities_label := $AbilitiesLabel

func _ready():
    update_ui()
    set_process(true)

func _process(delta):
    update_ui()

func update_ui():
    # player essence (if player exists)
    var players = get_tree().get_nodes_in_group("player")
    if players.size() > 0:
        var player = players[0]
        essence_label.text = "Esencia: %s" % player.current_essence
        # health if available
        if player.has_method("get_hp"):
            var hp = player.get_hp()
            var mx = player.get_max_hp()
            abilities_label.text = "HP: %d / %d | Abilities: %s" % [hp, mx, ",".join(Global.abilities.keys())]
        else:
            abilities_label.text = "Abilities: %s" % ",".join(Global.abilities.keys())
    else:
        essence_label.text = "Esencia: (player no instanciado)"
        abilities_label.text = "Abilities: %s" % ",".join(Global.abilities.keys())
