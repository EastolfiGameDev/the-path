class_name Idle
extends OnGround

func enter():
    Game.Animator.animate(owner, "idle")
#    owner.get_node("AnimationPlayer").play("idle")

func handle_input(event):
    return .handle_input(event)

func update(delta):
    var input_direction = get_input_direction()
    if input_direction:
        emit_signal("finished", "move")
