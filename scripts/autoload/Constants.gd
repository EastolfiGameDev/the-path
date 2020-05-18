extends Node

enum { STATUS_NONE, STATUS_INVINCIBLE, STATUS_POISONED, STATUS_STUNNED }

const STATES = {
    IDLE = "IDLE", MOVE = "MOVE",
    JUMP = "JUMP",
    PREVIOUS = "PREVIOUS"
}

const ACTION_KEYS = {
    JUMP = "jump", RUN = "run",
    MOVE_RIGHT = "ui_right", MOVE_LEFT = "ui_left"
}
