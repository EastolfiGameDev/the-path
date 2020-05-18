class_name OnGround
extends Motion

var speed = 0.0
var velocity = Vector2()

func handle_input(event):
    if event.is_action_pressed(Constants.ACTION_KEYS.JUMP):
        emit_signal("finished", Constants.STATES.JUMP)
    return .handle_input(event)
