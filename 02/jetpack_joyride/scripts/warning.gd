extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wait_timer: Timer = $WaitTimer
@onready var warning_timer: Timer = $WarningTimer
@onready var imminent_sfx: AudioStreamPlayer = $ImminentSfx

signal warning_end(this: JetpackJoyride.Warning)

var is_imminent = false
var player: JetpackJoyride.Player

func _ready() -> void:
    wait_timer.timeout.connect(_on_wait_timer_timeout)
    warning_timer.timeout.connect(_on_warning_timer_timeout)
    wait_timer.start()
    animated_sprite_2d.modulate.a = .75

func _physics_process(_delta: float) -> void:
    if not player:
        return

    var velocity_y = 0

    if not is_imminent:
        var diff = position.distance_to(player.position)
        var slow_diff: float = 20
        var axis: float = 1 if position.y < player.position.y else -1
        
        if diff < slow_diff:
            axis = min(diff / slow_diff, abs(axis)) * axis

        velocity_y = lerp(linear_velocity.y, axis * 250, .05)

    linear_velocity = Vector2(player.run_speed, velocity_y)


func _on_wait_timer_timeout() -> void:
    animated_sprite_2d.play("warn")
    warning_timer.start()
    collision_layer = 0
    collision_mask = 0
    z_index = 15
    animated_sprite_2d.modulate.a = 1
    is_imminent = true
    imminent_sfx.play()

func _on_warning_timer_timeout() -> void:
    warning_end.emit(self)
