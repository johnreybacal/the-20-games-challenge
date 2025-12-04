extends RigidBody2D

@export var speed = 50

signal out_of_bound()

var is_in_play = false

func _physics_process(delta: float) -> void:
    if not is_in_play:
        return
    var collision_info = move_and_collide(linear_velocity * delta)
    if collision_info:
        var bounce_velocity = linear_velocity.bounce(collision_info.get_normal()).normalized()
        linear_velocity = Vector2(speed * bounce_velocity.x, speed * bounce_velocity.y)

        var collider: Node2D = collision_info.get_collider()
        if collider.is_in_group("brick"):
            collider.queue_free()

        if collider.is_in_group("floor"):
            out_of_bound.emit()
            queue_free()

func play(direction: Vector2):
    is_in_play = true
    linear_velocity = Vector2(speed * direction.x, speed * direction.y)