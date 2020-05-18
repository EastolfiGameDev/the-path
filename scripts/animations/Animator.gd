extends Node

func animate(target: Node, animation: String, animation_node: String = "AnimationPlayer") -> void:
    if target.has_node(animation_node):
        var animation_player: AnimationPlayer = target.get_node(animation_node)
        if animation_player.has_animation(animation):
            animation_player.play(animation)
