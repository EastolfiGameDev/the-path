extends Motion

var corner_raycast_up: RayCast2D
var corner_raycast_down: RayCast2D
var last_corner_position

func enter():
    motion.y = 0
    apply_gravity = false
    Game.Animator.animate(owner, "corner_grab")
    
    if owner.has_node("BodyPivot/CornerRaycastUp"):
        corner_raycast_up = owner.get_node("BodyPivot/CornerRaycastUp")
    if owner.has_node("BodyPivot/CornerRaycastDown"):
        corner_raycast_down = owner.get_node("BodyPivot/CornerRaycastDown")
        if corner_raycast_down.get_collider():
            last_corner_position = corner_raycast_down.get_collider().global_position

func exit():
    apply_gravity = true

func handle_input(event):
    if event.is_action_pressed(Constants.ACTION_KEYS.JUMP):
        emit_signal("finished", Constants.STATES.JUMP)
#    elif event.is_action_pressed(Constants.ACTION_KEYS.CROUCH) and owner.is_on_floor():
#        emit_signal("finished", Constants.STATES.CROUCH)
    return .handle_input(event)

func handle_physics_process(delta):
    if corner_raycast_down.is_colliding():
        var corner = corner_raycast_down.get_collider()
        if corner:
            owner.global_position += corner.global_position - last_corner_position
            last_corner_position = corner.global_position
        else:
            print("No corner")
    else:
        print("No raycast")
#            if not pos1:
#                pos1 = corner.global_position
#            else:
##                owner.global_position += corner.global_position - pos1
#                print(corner.global_position - pos1)
#        print(corner.global_position)
#        print(corner_raycast.get_collision_normal())
#        if corner:
#            owner.global_position.y = corner.global_position 
#    else:
#        emit_signal("finished", Constants.STATES.PREVIOUS)

    .handle_physics_process(delta)
