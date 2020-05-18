# Collection of important methods to handle direction and animation
class_name Motion
extends State

const UP = Vector2(0, -1)
const GRAVITY = 10
const MAX_GRAVITY_SPEED = 500

var motion = Vector2.ZERO

#func handle_input(event):
#    if event.is_action_pressed("simulate_damage"):
#        emit_signal("finished", "stagger")

func handle_physics_process(delta):
    # Apply basic gravity
    motion.y = clamp(motion.y + GRAVITY, -MAX_GRAVITY_SPEED, MAX_GRAVITY_SPEED)
    
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

#    owner.get_node("BodyPivot").set_scale(Vector2(direction.x, 1))
