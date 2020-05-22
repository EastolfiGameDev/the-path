class_name OnGround
extends Motion

#var speed = 0.0
var velocity = Vector2()

func enter():
    snap_to_ground()

func handle_input(event):
    if event.is_action_pressed(Constants.ACTION_KEYS.JUMP) and owner.is_on_floor():
        emit_signal("finished", Constants.STATES.JUMP)
    elif event.is_action_pressed(Constants.ACTION_KEYS.CROUCH) and owner.is_on_floor():
        emit_signal("finished", Constants.STATES.CROUCH)

    return .handle_input(event)
