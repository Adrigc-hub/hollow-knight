# Bench/Checkpoint integration
# (Optional utility for level scripts to move player to checkpoint on start)

func move_player_to_checkpoint():
    var players = get_tree().get_nodes_in_group("player")
    if players.size() > 0:
        var player = players[0]
        var cp = Global.get_checkpoint_position()
        if cp != Vector2.ZERO:
            player.global_position = cp
