extends Node

var player_info_popup: Popup

func show_player_info_popup():
    if player_info_popup:
        Game.get_tree().current_scene.get_node("HUD").add_child(player_info_popup)
        _on_popup_ready(player_info_popup)
    else:
        player_info_popup = load("res://scenes/ui/popups/PlayerInfoPopup.tscn").instance()
        player_info_popup.connect("ready", self, "_on_popup_ready", [player_info_popup])
        Game.get_tree().current_scene.get_node("HUD").add_child(player_info_popup)


func dismiss_player_info_popup():
    Game.get_tree().current_scene.get_node("HUD").call_deferred("remove_child", player_info_popup)
    Game.get_tree().paused = false

func _on_popup_ready(popup: Popup):
    popup.popup_centered()
    Game.get_tree().paused = true
