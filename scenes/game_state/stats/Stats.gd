extends Node

export(float) var max_health := 10
export(float) var damage := 5
export(float) var defense := 5

var health: float

func _ready():
    health = max_health
