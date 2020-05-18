extends StateMachine

func _ready():
    states_map = {
        Constants.STATES.IDLE: $Idle,
        Constants.STATES.MOVE: $Move,
        Constants.STATES.JUMP: $Jump
    }

func _change_state(state_name):
    if not _active:
        return

    if state_name in [Constants.STATES.IDLE, Constants.STATES.MOVE, Constants.STATES.JUMP]:
        states_stack.push_front(states_map[state_name])
    
    if state_name == Constants.STATES.JUMP and current_state == $Move:
        $Jump.initialize($Move.speed, $Move.motion)

    ._change_state(state_name)
