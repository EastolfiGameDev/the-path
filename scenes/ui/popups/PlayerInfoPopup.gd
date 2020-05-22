extends WindowDialog

onready var health_label: Label = $MarginContainer/MainContainer/CenterRow/VBoxContainer/PlayerHealth/Label
onready var damage_label: Label = $MarginContainer/MainContainer/CenterRow/VBoxContainer/PlayerDamage/Label
onready var defense_label: Label = $MarginContainer/MainContainer/CenterRow/VBoxContainer/PlayerDefense/Label

func _on_PlayerInfoPopup_about_to_show():
    var player_stats = Game.GameState.get_player_stats()
    
    var health_text = "%s / %s" % [str(player_stats.health), str(player_stats.max_health)]
    health_label.text = health_text
    damage_label.text = str(player_stats.damage)
    defense_label.text = str(player_stats.defense)


func _on_PlayerInfoPopup_popup_hide():
    Game.Popups.dismiss_player_info_popup()
