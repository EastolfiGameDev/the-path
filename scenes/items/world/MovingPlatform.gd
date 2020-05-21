tool
extends KinematicBody2D

export(bool) var editor_process: bool = true setget set_editor_process
export(float) var speed: float = 400.0
export(NodePath) var waypoints_path = NodePath()
export(Texture) var platform_texture: Texture

onready var PlatformSprite: Sprite = $Sprite
onready var WaitTimer: Timer = $Timer
onready var Effects: Tween = $Effects
onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var Waypoints: PlatformWaypoints = get_node(waypoints_path)

var target_position: = Vector2()
var last_position: = Vector2()

func _ready():
    if not Waypoints:
        set_physics_process(false)
        return
    
    set_physics_process(true)
#    position = Waypoints.get_start_position()
    var start_position = Waypoints.get_start_position()
    position = start_position
    last_position = start_position
    
    if platform_texture:
        PlatformSprite.texture = platform_texture
        collision_shape.shape.extents = platform_texture.get_size() / 2

    _animate_to_next_point()

func _animate_to_next_point():
    var start: = last_position
    var end: = Waypoints.get_next_point_position()
    var duration: = end.length() / float(speed)
    var idle: = 1.0
    
#    print("distance -> " + str(start.distance_to(end)))
#    print("end.length -> " + str(end.length()))
#    print("speed -> " + str(speed))
#    print("duration -> " + str(end.length() / float(speed)))
#    print("duration -> " + str(start.distance_to(end) / float(speed)))
    
    last_position = end
#    print("Move from " + str(start) + " to " + str(end))
    Effects.interpolate_property(self, "position", start, end, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idle)
    Effects.start()

func set_editor_process(value: bool) -> void:
    editor_process = value
    
    if not Engine.editor_hint:
        return
    set_physics_process(true)
    WaitTimer.stop()

func _on_Timer_timeout():
    set_physics_process(true)


func _on_Effects_tween_completed(object, key):
    if key == ":position":
        _animate_to_next_point()
