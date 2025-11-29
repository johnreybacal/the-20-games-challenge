extends Node

@export var pipe_scene: PackedScene
@export var interval = 1.5
var timer = interval
var spawn_x = 450
var spawn_y_min = -125
var spawn_y_max = 125


func _process(delta: float) -> void:
    timer += delta

    if timer >= interval:
        timer = 0
        var pipe: PipeObstacle = pipe_scene.instantiate()
        var spawn_y = randf_range(spawn_y_min, spawn_y_max)
        pipe.position = Vector2(spawn_x, spawn_y)
        add_child(pipe)