extends OnGround

func enter():
    if owner.has_method("shrink_collision"):
        owner.shrink_collision()
    Game.Animator.animate(owner, "crouch")

func exit():
    if owner.has_method("expand_collision"):
        owner.expand_collision()

func handle_input(event):
    if event.is_action_released(Constants.ACTION_KEYS.CROUCH):
        emit_signal("finished", Constants.STATES.IDLE)
