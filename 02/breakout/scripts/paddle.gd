extends CharacterBody2D

@export var move_speed = 200

var is_playing = false
var initial_y = position.y

func _ready():
    initial_y = position.y

func _physics_process(delta: float) -> void:
    var target: Vector2

    if is_playing:
        target = get_global_mouse_position()
        target.y = position.y
    else:
        target = Vector2(0, position.y)

    var diff = position.distance_to(target)
    var slow_diff: float = 20
    var axis = 1 if position.x < target.x else -1

    if diff < slow_diff:
        axis = min(diff / slow_diff, abs(axis)) * axis

    if axis:
        velocity = Vector2(axis * move_speed, 0)
        move_and_slide()

    # Return to initial y if pushed downwards
    if position.y != initial_y:
        var return_position = Vector2(position.x, initial_y)
        velocity = position.direction_to(return_position) * move_speed * delta
        move_and_slide()
