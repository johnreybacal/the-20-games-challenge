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

        # To avoid getting stuck in a single line
        if abs(bounce_velocity.x) <= 0.01:
            var direction = (1 if randi_range(0, 1) == 1 else -1) if bounce_velocity.x == 0 else sign(bounce_velocity.x)
            bounce_velocity.x = randf_range(0.1, 0.5) * direction
        if abs(bounce_velocity.y) <= 0.01:
            var direction = (1 if randi_range(0, 1) == 1 else -1) if bounce_velocity.y == 0 else sign(bounce_velocity.y)
            bounce_velocity.y = randf_range(0.1, 0.5) * direction

        bounce_velocity = bounce_velocity.normalized()

        linear_velocity = Vector2(speed * bounce_velocity.x, speed * bounce_velocity.y)

        var collider: Node2D = collision_info.get_collider()
        if collider.is_in_group("brick"):
            collider.queue_free()

        if collider.is_in_group("floor"):
            out_of_bound.emit()
            queue_free()
        
        # Push paddle downwards
        if collider.is_in_group("paddle"):
            var paddle = (collider as Breakout.Paddle)
            paddle.velocity = Vector2(0, 150)
            paddle.move_and_slide()
            

func play(direction: Vector2):
    is_in_play = true
    linear_velocity = Vector2(speed * direction.x, speed * direction.y)