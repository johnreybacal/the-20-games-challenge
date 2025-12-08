extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wait_timer: Timer = $WaitTimer
@onready var warning_timer: Timer = $WarningTimer
signal warning_end(this)
var target: Node2D
var move_speed: float

func _ready() -> void:
    wait_timer.timeout.connect(_on_wait_timer_timeout)
    warning_timer.timeout.connect(_on_warning_timer_timeout)
    wait_timer.start()

func _physics_process(_delta: float) -> void:
    if not target:
        return
    
    var diff = position.distance_to(target.position)
    var slow_diff: float = 20
    var axis = 1 if position.y < target.position.y else -1

    if diff < slow_diff:
        axis = min(diff / slow_diff, abs(axis)) * axis

    if axis:
        linear_velocity = Vector2(move_speed, axis * move_speed * .5)


func _on_wait_timer_timeout() -> void:
    animated_sprite_2d.play("warn")
    warning_timer.start()

func _on_warning_timer_timeout() -> void:
    warning_end.emit(self)
