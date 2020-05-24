extends StateMachine

func _ready():
    states_map = {
        Constants.STATES.IDLE: $Idle,
        Constants.STATES.MOVE: $Move,
        Constants.STATES.JUMP: $Jump,
        Constants.STATES.CROUCH: $Crouch,
        Constants.STATES.CORNER_GRAB: $CornerGrab,
        Constants.STATES.ATTACK: $Attack
    }

func _change_state(state_name):
    if not _active:
        return

    """
    If I'm changing to an state to which I want to do a PREVIOUS, save the it in the stack
    """
    if state_name in [Constants.STATES.IDLE, Constants.STATES.MOVE]:
        states_stack.push_front(states_map[state_name])
    
    if state_name == Constants.STATES.JUMP and current_state == $Move:
        $Jump.initialize($Move.speed, $Move.motion)

    if state_name == Constants.STATES.IDLE and current_state == $Move:
        $Idle.initialize($Move.motion)

    if state_name == Constants.STATES.JUMP and current_state == $CornerGrab:
        $Jump.motion.y = 0

    ._change_state(state_name)


func _input(event):
    """
    Here we only handle input that can interrupt states, attacking in this case
    otherwise we let the state node handle it
    """
    if event.is_action_pressed(Constants.ACTION_KEYS.ATTACK_MAIN):
        if current_state == $Attack:
            return
        _change_state(Constants.STATES.ATTACK)
        return
    current_state.handle_input(event)
