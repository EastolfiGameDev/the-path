extends Node

export(float) var max_health := 10.0 setget set_max_health
export(float) var damage := 5.0 setget set_damage
export(float) var defense := 5.0 setget set_defense

var health: float setget set_health

func _ready():
    health = max_health

func set_max_health(value: float):
    max_health = value
    
    var updated_stats = { max_health = max_health }
    if max_health < health:
        health = max_health
        updated_stats.health = health
    
    Game.GameState.update_player_stats(updated_stats)

func set_health(value: float):
    health = value
    
    Game.GameState.update_player_stats({ health = health })

func set_damage(value: float):
    damage = value
    Game.GameState.update_player_stats({ damage = damage })

func set_defense(value: float):
    defense = value
    Game.GameState.update_player_stats({ defense = defense })
