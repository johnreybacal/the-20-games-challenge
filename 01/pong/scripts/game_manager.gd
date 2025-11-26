extends Node

@export var play_area: PlayArea = null
@export var hud: Hud = null
@export var p1: Paddle = null
@export var p2: Paddle = null
@export var ball_scene: PackedScene = null

var p1_score = 0
var p2_score = 0
var is_rally_started = false
var rally_starter: Paddle = null
var ball: Ball = null
var rally = 1

func _ready() -> void:
    if play_area:
        play_area.scored.connect(_on_play_area_scored)
    if p1:
        rally_starter = p1
    spawn_ball()

func _process(_delta: float) -> void:
    if not is_rally_started:
        if ball:
            ball.global_position = Vector2(rally_starter.global_position.x + (10 if rally_starter == p1 else -10), rally_starter.global_position.y)
            
        is_rally_started = Input.is_action_just_pressed("01_pong_fire")
        if is_rally_started:
            hud.set_start_label_visibility(false)
            ball.is_started = true
            ball.play_hit_sound()
            rally = 1
            hud.set_rally_score(rally)


func _on_play_area_scored(player: int) -> void:
    if player == 1:
        p1_score += rally
        hud.set_p1_score(p1_score)
        rally_starter = p2
    else:
        p2_score += rally
        hud.set_p2_score(p2_score)
        rally_starter = p1
    rally = 0
    hud.set_rally_score(rally)

    call_deferred("spawn_ball")

func spawn_ball():
    is_rally_started = false
    ball = ball_scene.instantiate()
    ball.direction = Vector2(1 if rally_starter == p1 else -1, randf_range(-0.5, 0.5)).normalized()
    add_child(ball)
    hud.set_start_label_visibility(true)
    ball.on_paddle_hit.connect(on_paddle_hit)

func on_paddle_hit():
    rally += 1
    hud.set_rally_score(rally)
