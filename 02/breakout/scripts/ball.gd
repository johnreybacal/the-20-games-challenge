extends RigidBody2D

@export var speed = 50

func _ready():
    linear_velocity = Vector2(speed, speed * -1)

func _physics_process(delta: float) -> void:
    var collision_info = move_and_collide(linear_velocity * delta)
    if collision_info:
        var bounce_velocity = linear_velocity.bounce(collision_info.get_normal())
        linear_velocity = Vector2(speed * sign(bounce_velocity.x), speed * sign(bounce_velocity.y))

        var collider: Node2D = collision_info.get_collider()
        if collider.is_in_group("brick"):
            collider.queue_free()
