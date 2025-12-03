extends RigidBody2D

@export var move_speed = 200

func _physics_process(delta: float) -> void:
    var mouse_pos = get_global_mouse_position()
    var diff = abs(mouse_pos.x - position.x)
    var slow_diff: float = 5
    var axis = 1 if position.x < mouse_pos.x else -1

    if diff < slow_diff:
        axis = min(diff / slow_diff, abs(axis)) * axis

    var velocity = Vector2(linear_velocity.x + axis * move_speed * delta, 0)
    move_and_collide(velocity)
