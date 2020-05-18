extends Label

var start_position = Vector2.ZERO

func _ready():
    start_position = rect_position

func _physics_process(delta):
    rect_position = get_parent().get_node("BodyPivot").position + start_position

func _on_Player_state_changed(state):
    text = state.get_name()
