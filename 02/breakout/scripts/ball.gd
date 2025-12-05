extends RigidBody2D

@export var speed = 50
@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound

signal on_out_of_bound()
signal on_score()

var is_in_play = false

func _physics_process(delta: float) -> void:
    if not is_in_play:
        return
    var collision_info = move_and_collide(linear_velocity * delta)
    if collision_info:
        play_hit_sound()

        var bounce_velocity = linear_velocity.bounce(collision_info.get_normal()).normalized()

        # To avoid getting stuck in a single line
        if abs(bounce_velocity.x) <= 0.01:
            var direction = (1 if randi_range(0, 1) == 1 else -1) if bounce_velocity.x == 0 else sign(bounce_velocity.x)
            bounce_velocity.x = randf_range(0.1, 0.5) * direction
        if abs(bounce_velocity.y) <= 0.01:
            var direction = (1 if randi_range(0, 1) == 1 else -1) if bounce_velocity.y == 0 else sign(bounce_velocity.y)
            bounce_velocity.y = randf_range(0.1, 0.5) * direction

        bounce_velocity = bounce_velocity.normalized()

        set_moving_direction(bounce_velocity)

        var collider: Node2D = collision_info.get_collider()
        if collider.is_in_group("brick"):
            score_sound.pitch_scale = randf_range(1.75, 2)
            score_sound.play()
            collider.queue_free()
            increase_speed()
            on_score.emit()

        if collider.is_in_group("floor"):
            on_out_of_bound.emit()
            queue_free()
        
        # Push paddle downwards
        if collider.is_in_group("paddle") and bounce_velocity.y < 0:
            var paddle = (collider as Breakout.Paddle)
            paddle.velocity = Vector2(0, 150)
            paddle.move_and_slide()

func play_hit_sound():
    hit_sound.pitch_scale = randf_range(0.75, 1.25)
    hit_sound.play()

func play(direction: Vector2):
    is_in_play = true
    linear_velocity = Vector2(speed * direction.x, speed * direction.y)
    play_hit_sound()

func increase_speed():
    speed += 1
    set_moving_direction(linear_velocity)

func set_moving_direction(direction: Vector2):
    var normal = direction.normalized()
    linear_velocity = Vector2(speed * normal.x, speed * normal.y)
