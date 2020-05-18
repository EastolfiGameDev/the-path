# Collection of important methods to handle direction and animation
class_name Motion
extends State

const UP = Vector2(0, -1)
const GRAVITY = 10

var motion = Vector2.ZERO

func handle_physics_process(delta):
    motion.y += GRAVITY
    
    if (owner as KinematicBody2D).is_on_floor():
        motion.y = 0
    
    motion = (owner as KinematicBody2D).move_and_slide(motion, UP)

func get_input_direction():
    var input_direction = Vector2()
    
    input_direction.x = \
        int(Input.is_action_pressed(Constants.ACTION_KEYS.MOVE_RIGHT)) - \
        int(Input.is_action_pressed(Constants.ACTION_KEYS.MOVE_LEFT))
    
    return input_direction

func update_look_direction(direction):
    if direction and owner.look_direction != direction:
        owner.look_direction = direction

    if not direction.x in [-1, 1]:
        return

    owner.get_node("BodyPivot").set_scale(Vector2(direction.x, 1))
