extends Node

@export var play_area: PlayArea = null
@export var hud: Hud = null
@export var p1: Paddle = null
@export var p2: Paddle = null
@export var ball_scene: PackedScene = null
@export var confetti_scene: PackedScene = null
@export var is_p2_ai = false

var p1_score = 0
var p2_score = 0
var is_rally_started = false
var rally_starter: Paddle = null
var ball: Ball = null
var rally = 0
var first_score = null

func _ready() -> void:
    is_p2_ai = not Global.has_p2
    if play_area:
        play_area.scored.connect(_on_play_area_scored)
    p2.set_is_ai(is_p2_ai)
    init()

func init():
    if ball:
        ball.is_in_play = false
        ball.queue_free()
    is_rally_started = false
    first_score = null
    rally_starter = p1
    p1_score = 0
    p2_score = 0
    rally = 0
    hud.init()
    spawn_ball()

func _process(delta: float) -> void:
    if not is_rally_started:
        if Input.is_action_just_pressed("01_pong_quit"):
            Global.quit_to_main_menu()
        if Input.is_action_just_pressed("01_pong_reset") and first_score != null:
            init()
            return
        if ball:
            ball.global_position = Vector2(rally_starter.global_position.x + (10 if rally_starter == p1 else -10), rally_starter.global_position.y)
        if is_p2_ai:
            move_ai(delta)
            
        is_rally_started = Input.is_action_just_pressed("01_pong_space")
        if is_rally_started:
            hud.set_start_label_visibility(false)
            hud.toggle_paused(get_tree().paused)
            ball.is_in_play = true
            ball.play_hit_sound()
            rally = 1
            hud.set_rally_score(rally)
    else:
        if Input.is_action_just_pressed("01_pong_space"):
            get_tree().paused = not get_tree().paused
            hud.toggle_paused(get_tree().paused)
        if Input.is_action_just_pressed("01_pong_reset") and get_tree().paused:
            init()
            get_tree().paused = false
        if Input.is_action_just_pressed("01_pong_quit") and get_tree().paused:
            Global.quit_to_main_menu()

        if is_p2_ai:
            move_ai(delta, ball)

func move_ai(delta: float, target = null):
    var target_y = target.global_position.y if target else 0
    var p2_y = p2.global_position.y
    var diff = abs(target_y - p2_y)
    var target_axis: float = 0
    var slow_diff: float = 10

    if target_y > p2_y:
        target_axis = 1
    elif target_y < p2_y:
        target_axis = -1
    else:
        target_axis = 0

    # Gradually slow down when near
    if diff < slow_diff:
        target_axis = min(diff / slow_diff, abs(target_axis)) * target_axis

    if p2.paddle_position == Paddle.PaddlePosition.Middle:
        # Move faster when the ball is farther away
        var move_delta = max(diff / 2, abs(target_axis)) if target else 1.25
        p2.ai_axis = move_toward(p2.ai_axis, target_axis, delta * move_delta)
    else:
        # Move faster when at the edges
        var move_delta = max(diff, 5)
        p2.ai_axis = move_toward(p2.ai_axis, target_axis, delta * move_delta)


func _on_play_area_scored(player: int) -> void:
    spawn_confetti(player)
    if player == 1:
        p1_score += rally
        hud.set_p1_score(p1_score)
        rally_starter = p2
    else:
        p2_score += rally
        hud.set_p2_score(p2_score)
        rally_starter = p1
    if first_score == null:
        first_score = player
        hud.add_reset_to_start_label()
    rally = 0
    is_rally_started = false
    hud.set_rally_score(rally)

    call_deferred("spawn_ball")

func spawn_confetti(player: int):
    var confetti: GPUParticles2D = confetti_scene.instantiate()
    confetti.global_position = Vector2(ball.global_position.x + (-10 if player == 1 else 10), ball.global_position.y)
    confetti.one_shot = true
    confetti.emitting = true
    confetti.finished.connect(confetti.queue_free)
    (confetti.process_material as ParticleProcessMaterial).direction = Vector3(-1 if player == 1 else 1, -1, 0)
    add_child(confetti)
        
    
func spawn_ball():
    ball = ball_scene.instantiate()
    ball.direction = Vector2(1 if rally_starter == p1 else -1, randf_range(-0.5, 0.5)).normalized()
    add_child(ball)
    hud.set_start_label_visibility(true)
    ball.on_paddle_hit.connect(on_paddle_hit)

func on_paddle_hit():
    rally += 1
    hud.set_rally_score(rally)
