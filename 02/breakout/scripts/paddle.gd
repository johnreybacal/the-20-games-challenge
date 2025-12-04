extends RigidBody2D

@export var move_speed = 200

var is_playing = false

func _physics_process(delta: float) -> void:
    var target_x: float

    if is_playing:
        target_x = get_global_mouse_position().x
    else:
        target_x = 0
    var diff = abs(target_x - position.x)
    var slow_diff: float = 5
    var axis = 1 if position.x < target_x else -1

    if diff < slow_diff:
        axis = min(diff / slow_diff, abs(axis)) * axis

    var velocity = Vector2(linear_velocity.x + axis * move_speed * delta, 0)
    move_and_collide(velocity)
