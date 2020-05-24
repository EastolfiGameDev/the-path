extends Position2D

class_name WeaponPivot

var z_index_start = 0

func _ready():
    if get_parent().has_user_signal("direction_changed"):
        get_parent().connect("direction_changed", self, "_on_Parent_direction_changed")
    z_index_start = z_index

func _on_Parent_direction_changed(new_direction: Vector2):
    rotation = new_direction.angle()

    match new_direction:
        Vector2(0, -1):
            z_index = z_index_start - 1
        _:
            z_index = z_index_start
