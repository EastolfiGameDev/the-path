extends Node

signal player_stats_updated(new_stats)

var player_stats = {}

func load_game_state():
    pass

func get_player_stats() -> Dictionary:
    return player_stats

func update_player_stats(stats: Dictionary):
    for stat in stats:
        player_stats[stat] = stats[stat]
    
    emit_signal("player_stats_updated", stats)
