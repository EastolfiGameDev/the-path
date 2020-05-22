extends CanvasLayer

onready var life_bar: TextureProgress = $TopRow/LifeBar
onready var health_normal = preload("res://assets/sprites/ui/bars/bars_normal.png")
onready var health_warning = preload("res://assets/sprites/ui/bars/bars_warning.png")
onready var health_danger = preload("res://assets/sprites/ui/bars/bars_low.png")

func _ready():
    Game.GameState.connect("player_stats_updated", self, "on_player_stats_updated")

func _input(event: InputEvent):
    if event.is_action_pressed(Constants.ACTION_KEYS.UI_MENU):
        Game.Popups.show_player_info_popup()

func _update_lifebar():
    var health = life_bar.value
    var max_health = life_bar.max_value
    
    var health_percentage = health * 100 / max_health
    if health_percentage > 60:
        life_bar.texture_progress = health_normal
    elif health_percentage <= 60 and health_percentage > 30:
        life_bar.texture_progress = health_warning
    if health_percentage <= 30:
        life_bar.texture_progress = health_danger

func _update_max_health(max_health: float):
    life_bar.max_value = max_health
    _update_lifebar()

func _update_health(health: int):
    life_bar.value = health
    _update_lifebar()

#func _update_damage(damage: float):
#    pass
#
#func _update_defense(defense: float):
#    pass

func on_player_stats_updated(stats: Dictionary):
    if stats.has("max_health"):
        _update_max_health(stats.max_health)
    
    if stats.has("health"):
        _update_health(stats.get("health"))
