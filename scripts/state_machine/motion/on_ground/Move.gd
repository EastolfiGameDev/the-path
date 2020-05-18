class_name Move
extends OnGround

export(float) var MAX_WALK_SPEED = 450
export(float) var MAX_RUN_SPEED = 700
export(float) var ACCELERATION = 950

var speed = 0

func enter():
    motion = Vector2.ZERO

    var input_direction = get_input_direction()
    update_look_direction(input_direction)
#    Game.Animator.animate(owner, "walk")
    Game.Animator.animate(owner, "move")

func handle_input(event):
    return .handle_input(event)

func handle_physics_process(delta):
    var input_direction = get_input_direction()
    if not input_direction:
        emit_signal("finished", Constants.STATES.IDLE)
        return

    update_look_direction(input_direction)

    if input_direction:
        if Input.is_action_pressed(Constants.ACTION_KEYS.RUN):
            run(input_direction, delta)
        else:
            walk(input_direction, delta)

#    if owner.get_slide_count() >= 0:
#        var collision_info = owner.get_slide_collision(0)
#
#        if not collision_info:
#            return
#        if speed == MAX_RUN_SPEED and collision_info.collider.is_in_group("environment"):
#            return null
    
    .handle_physics_process(delta)

func move(speed: float, direction: Vector2, delta):
    self.speed = speed
    motion = motion.move_toward(direction.normalized() * speed, ACCELERATION * delta)

func walk(direction: Vector2, delta):
    return move(MAX_WALK_SPEED, direction, delta)

func run(direction: Vector2, delta):
    move(MAX_RUN_SPEED, direction, delta)
