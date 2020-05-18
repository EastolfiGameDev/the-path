class_name Jump
extends Motion

export(float) var BASE_MAX_HORIZONTAL_SPEED = 200.0
#export(float) var MAX_HORIZONTAL_SPEED_INCREMENT = 100.0

export(float) var AIR_ACCELERATION = 50.0
export(float) var AIR_DECCELERATION = 100.0
export(float) var AIR_STEERING_POWER = 50.0

export(float) var JUMP_HEIGHT = 120.0

var enter_velocity = Vector2()

var max_horizontal_speed = BASE_MAX_HORIZONTAL_SPEED
var horizontal_speed = 0.0
var horizontal_velocity = Vector2()
var is_in_air = false

func initialize(speed: float, velocity: Vector2):
    enter_velocity = velocity
    horizontal_speed = speed
    
    if speed > 0.0:
        max_horizontal_speed = speed
    else:
         max_horizontal_speed = BASE_MAX_HORIZONTAL_SPEED

func enter():
    var input_direction = get_input_direction()   
    update_look_direction(input_direction)

    if input_direction:
        horizontal_velocity = enter_velocity
    else:
        horizontal_velocity = Vector2.ZERO

    is_in_air = true
    motion.y -= JUMP_HEIGHT

    Game.Animator.animate(owner, "jump")

func handle_physics_process(delta):
    _check_landing()
    _move_horizontally()

    .handle_physics_process(delta)

func _check_landing():
    yield(get_tree(), "idle_frame")
    if owner.is_on_floor() and is_in_air:
        is_in_air = false
        emit_signal("finished", Constants.STATES.PREVIOUS)

func _move_horizontally():
    var input_direction = get_input_direction()
    update_look_direction(input_direction)

    if input_direction:
        horizontal_speed += AIR_ACCELERATION
    else:
        horizontal_speed -= AIR_DECCELERATION
    horizontal_speed = clamp(horizontal_speed, 0, max_horizontal_speed)

    var target_velocity = horizontal_speed * input_direction.normalized()
    var steering_velocity = (target_velocity - horizontal_velocity).normalized() * AIR_STEERING_POWER
    horizontal_velocity += steering_velocity

    motion.x = horizontal_velocity.x
