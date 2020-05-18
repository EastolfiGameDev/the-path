extends Node

enum { STATUS_NONE, STATUS_INVINCIBLE, STATUS_POISONED, STATUS_STUNNED }

const STATES = {
    IDLE = "IDLE", MOVE = "MOVE",
    JUMP = "JUMP", CROUCH = "CROUCH",
    PREVIOUS = "PREVIOUS"
}

const ACTION_KEYS = {
    JUMP = "jump", RUN = "run", CROUCH = "crouch",
    MOVE_RIGHT = "move_right", MOVE_LEFT = "move_left"
}
