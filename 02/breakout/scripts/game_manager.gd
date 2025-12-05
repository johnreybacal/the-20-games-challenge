extends Node2D

@export var colors: Array[Color] = ["#92140C", "#BE5A38", "#BE7C4D"]
@export var paddle: Breakout.Paddle
@export var hud: Breakout.Hud
@export var brick_scene: PackedScene
@export var ball_scene: PackedScene
@export var ball_spawn_position = Vector2(0, 75)

@onready var reset_timer: Timer = $ResetTimer
@onready var out_of_bound_sound: AudioStreamPlayer2D = $OutOfBoundSound

var is_playing = false
var can_play = true
var ball: Breakout.Ball
var life = 3
var score = 0
var high_score = 0
var bricks_left = 0

const SESSION_HIGH_SCORE_KEY = "02_breakout_high_score"

func _ready():
    var pos_x = -136
    var pos_y = -70
    var color_index = 0
    for row in range(9):
        var x = pos_x + (16 * row)
        for col in range(row, 18 - row):
            var brick: Node2D = brick_scene.instantiate()
            brick.position = Vector2(x, pos_y)
            brick.modulate = colors[color_index]
            add_child(brick)
            x += 16
            bricks_left += 1
        pos_y += 6.5
        color_index += 1
        if color_index == len(colors):
            color_index = 0
    
    spawn_ball()
    reset_timer.timeout.connect(on_reset_timer_timeout)

    hud.set_life(life)
    hud.set_score(score)
    high_score = Global.session_data.get(SESSION_HIGH_SCORE_KEY, 0)
    hud.set_high_score(high_score)

func _input(event: InputEvent):
    if can_play and not is_playing and event.is_action_pressed("02_breakout_click"):
        var direction = ball.position.direction_to(get_global_mouse_position())
        ball.play(direction)
        is_playing = true
        paddle.is_playing = true
    
func spawn_ball():
    ball = ball_scene.instantiate() as Breakout.Ball
    ball.on_out_of_bound.connect(on_lose_ball)
    ball.on_score.connect(on_score)
    ball.position = ball_spawn_position
    add_sibling.call_deferred(ball)

func on_lose_ball():
    out_of_bound_sound.play()
    can_play = false
    is_playing = false
    paddle.is_playing = false
    life -= 1
    hud.set_life(life)

    if life == 0:
        on_game_over()
        return
        
    reset_timer.start()

func on_score():
    score += 1
    bricks_left -= 1
    hud.set_score(score)

    if bricks_left <= 0:
        on_game_over()
        ball.queue_free()
        can_play = false
        is_playing = false
        paddle.is_playing = false

func on_reset_timer_timeout():
    spawn_ball()
    can_play = true

func on_game_over():
    if score > high_score:
        Global.session_data.set(SESSION_HIGH_SCORE_KEY, score)
        hud.set_high_score(score)
    var is_winner = bricks_left == 0
    hud.on_game_over(is_winner)
