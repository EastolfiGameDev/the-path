extends Area2D

signal attack_finished

enum STATES { NONE, IDLE, ATTACK }
enum ATTACK_INPUT_STATES { IDLE, LISTENING, REGISTERED }

const MAX_COMBO_COUNT = 3
const COMBO_LIST = [{
    'damage': 1,
    'animation': 'attack_fast',
    'effect': null
}, {
    'damage': 3,
    'animation': 'attack_medium',
    'effect': null
}, {
    'damage': 2,
    'animation': 'attack_final',
    'effect': null
}]

var state = STATES.NONE
var attack_input_state = ATTACK_INPUT_STATES.IDLE
var ready_next_attack = false
var combo_count = 0
var current_attack = {}

func _ready():
    var weapon_pivot = owner
    if weapon_pivot.owner.has_node("StateMachine"):
        var fsm = weapon_pivot.owner.get_node("StateMachine")
        fsm.connect("state_changed", self, "_on_StateMachine_state_changed")
    
    _change_state(STATES.IDLE)

"""
Used to check if we attack while already attack, for combos
"""
func _input(event):
    # If we are not attacking, dont check the inputs
    if state != STATES.ATTACK:
        return
    
    # If we are not ready to handle another attack, dont check the inputs
    if attack_input_state != ATTACK_INPUT_STATES.LISTENING:
        return
    
    # Attack command validated
    if event.is_action_pressed(Constants.ACTION_KEYS.ATTACK_MAIN):
        attack_input_state = ATTACK_INPUT_STATES.REGISTERED

func _change_state(new_state):
    match state:
        STATES.ATTACK:
            attack_input_state = ATTACK_INPUT_STATES.IDLE
            ready_next_attack = false

    match new_state:
        STATES.IDLE:
            combo_count = 0
            visible = false
            monitoring = false
            $AnimationPlayer.stop()
        STATES.ATTACK:
            visible = true
            monitoring = true
            current_attack = COMBO_LIST[combo_count - 1]
            $AnimationPlayer.play(current_attack.animation)

    state = new_state

func _physics_process(delta):
    if attack_input_state == ATTACK_INPUT_STATES.REGISTERED and ready_next_attack:
        _attack()

func _attack():
    combo_count += 1
    _change_state(STATES.ATTACK)

func set_listening_for_attack():
    attack_input_state = ATTACK_INPUT_STATES.LISTENING

func set_ready_for_next_attack():
    ready_next_attack = true

func _on_StateMachine_state_changed(current_state):
    if current_state.name == "Attack":
        _attack()

func _on_AnimationPlayer_animation_finished(anim_name):
    if not current_attack:
        return

    if attack_input_state == ATTACK_INPUT_STATES.REGISTERED and combo_count < MAX_COMBO_COUNT:
        _attack()
    else:
        _change_state(STATES.IDLE)
        emit_signal("attack_finished")
