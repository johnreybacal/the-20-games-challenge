extends Node2D

@export var colors: Array[Color] = ["#92140C", "#BE5A38", "#BE7C4D"]
@export var paddle: Breakout.Paddle
@export var brick_scene: PackedScene
@export var ball_scene: PackedScene
@export var ball_spawn_position = Vector2(0, 75)

@onready var reset_timer: Timer = $ResetTimer

var is_playing = false
var can_play = true
var ball: Breakout.Ball

func _ready():
    var pos_x = -152
    var pos_y = -70
    for row in range(3):
        var x = pos_x
        for col in range(20):
            var brick: Node2D = brick_scene.instantiate()
            brick.position = Vector2(x, pos_y)
            brick.modulate = colors[row]
            add_child(brick)
            x += 16
        pos_y += 6.5
    spawn_ball()
    reset_timer.timeout.connect(on_reset_timer_timeout)

func _process(_delta: float):
    if can_play and not is_playing and Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
        var direction = ball.position.direction_to(get_global_mouse_position())
        ball.play(direction)
        is_playing = true
        paddle.is_playing = true


func spawn_ball():
    ball = ball_scene.instantiate() as Breakout.Ball
    ball.out_of_bound.connect(on_lose_ball)
    ball.position = ball_spawn_position
    add_sibling.call_deferred(ball)

func on_lose_ball():
    can_play = false
    is_playing = false
    paddle.is_playing = false
    reset_timer.start()

func on_reset_timer_timeout():
    spawn_ball()
    can_play = true
