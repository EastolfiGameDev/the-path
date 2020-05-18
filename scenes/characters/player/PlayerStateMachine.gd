extends StateMachine

func _ready():
    states_map = {
        Constants.STATES.IDLE: $Idle
    }
