extends Node

enum { STATUS_NONE, STATUS_INVINCIBLE, STATUS_POISONED, STATUS_STUNNED }

const STATES = {
    IDLE = "IDLE", MOVE = "MOVE",
    JUMP = "JUMP", CROUCH = "CROUCH", CORNER_GRAB = "CORNER_GRAB",
    ATTACK = "ATTACK",
    PREVIOUS = "PREVIOUS"
}

const ACTION_KEYS = {
    JUMP = "jump", RUN = "run", CROUCH = "crouch",
    MOVE_RIGHT = "move_right", MOVE_LEFT = "move_left",
    ATTACK_MAIN = "attack_main", ATTACK_SECONDARY = "attack_secondary",
    UI_MENU = "ui_cancel"
}
