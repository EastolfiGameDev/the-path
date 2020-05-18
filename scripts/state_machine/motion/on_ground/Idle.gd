class_name Idle
extends OnGround

func enter():
    Game.Animator.animate(owner, "idle")

func handle_input(event):
    return .handle_input(event)

func handle_physics_process(delta):
    var input_direction = get_input_direction()
    if input_direction:
        emit_signal("finished", Constants.STATES.MOVE)

    .handle_physics_process(delta)
