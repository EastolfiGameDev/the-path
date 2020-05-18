"""
Base interface for a generic state machine
It handles initializing, setting the machine active or not
delegating _physics_process, _input calls to the State nodes,
and changing the current/active state.
See the PlayerV2 scene for an example on how to use it
"""
extends Node

class_name StateMachine

signal state_changed(current_state)

"""
You must set a starting node from the inspector or on
the node that inherits from this state machine interface
If you don't the game will crash (on purpose, so you won't 
forget to initialize the state machine)
"""
export(NodePath) var START_STATE
var states_map = {}

var states_stack = []
var current_state = null
var _active = false setget set_active

func _ready():
    for child in get_children():
#        print((child as Node).has_user_signal("finished"))
        child.connect("finished", self, "_change_state")
    initialize(START_STATE)

func initialize(start_state):
    set_active(true)
    states_stack.push_front(get_node(start_state))
    current_state = states_stack[0]
    emit_signal("state_changed", current_state)
    current_state.enter()

func set_active(value):
    _active = value
    set_physics_process(value)
    set_process_input(value)
    if not _active:
        states_stack = []
        current_state = null

func _input(event):
    current_state.handle_input(event)

func _physics_process(delta):
    current_state.handle_physics_process(delta)

func _on_animation_finished(anim_name):
    if not _active:
        return
    current_state._on_animation_finished(anim_name)

func _change_state(state_name):
    if not _active:
        return
    
    if state_name == Constants.STATES.PREVIOUS and states_stack.size() > 0:
        states_stack.pop_front()
    elif states_map.has(state_name):
        states_stack[0] = states_map[state_name]
    else:
        return
    
    current_state.exit() 
    
    current_state = states_stack[0]
    emit_signal("state_changed", current_state)
    
    if state_name != "previous":
        current_state.enter()
