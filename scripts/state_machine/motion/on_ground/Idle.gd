class_name Idle
extends OnGround

export(float) var FRICTION = 950.0

func _ready():
    motion = Vector2.ZERO

func initialize(move_motion: Vector2):
    motion = move_motion

func enter():
    Game.Animator.animate(owner, "idle")

func handle_input(event):
    return .handle_input(event)

func handle_physics_process(delta):
    var input_direction = get_input_direction()
    if input_direction:
        emit_signal("finished", Constants.STATES.MOVE)
    else:
        motion.x = motion.move_toward(Vector2.ZERO, FRICTION * delta).x

    .handle_physics_process(delta)
