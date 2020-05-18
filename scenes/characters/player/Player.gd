extends KinematicBody2D

signal direction_changed(new_direction)

var look_direction = Vector2(1, 0) setget set_look_direction

onready var sprite: Sprite = $Sprite
onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
    expand_collision()

func set_look_direction(value: Vector2):
    look_direction = value
    sprite.flip_h = true if value.x < 0 else false
    emit_signal("direction_changed", value)

#var t: float = 0
#func _process(delta):
#    t += delta * 5
#    var scale_add = sin(t * 2) * 0.2
#    scale = Vector2.ONE * (1 + scale_add)
#    rotation_degrees = sin(t) * 10

func shrink_collision():
    var shape: CapsuleShape2D = collision.shape

    shape.radius = 5
    shape.height = 11.5
    collision.position.y = 6.7

func expand_collision():
    var shape: CapsuleShape2D = collision.shape

    shape.radius = 5
    shape.height = 20
    collision.position.y = 3
