extends Node2D

@onready var bird_timer: Timer = $BirdTimer
@onready var boulder_timer: Timer = $BoulderTimer
@onready var run_timer: Timer = $RunTimer

@export var player: JetpackJoyride.Player
@export var warning_scene: PackedScene
@export var bird_scene: PackedScene
@export var boulder_scene: PackedScene
@export var hud: JetpackJoyride.Hud

var warnings: Array[JetpackJoyride.Warning] = []
var initial_x

const SESSION_HIGH_SCORE_KEY = "02_jetpack_joyride"

func _ready():
    bird_timer.timeout.connect(Callable(spawn_warning).bind(spawn_bird))
    bird_timer.timeout.connect(reset_bird_timer)
    bird_timer.start()

    boulder_timer.timeout.connect(Callable(spawn_warning).bind(spawn_boulder))
    boulder_timer.timeout.connect(reset_boulder_timer)
    boulder_timer.start()

    run_timer.timeout.connect(increase_speed)

    player.died.connect(game_over)
    initial_x = player.position.x
    

func increase_speed():
    player.run_speed += 10


func spawn_warning(callable: Callable):
    var warning: JetpackJoyride.Warning = warning_scene.instantiate()
    var y = randf_range(player.position.y - 250, player.position.y + 250)
    y = clampf(y, -333, 269)
    
    warning.position = Vector2(player.position.x + 1100, y)
    warning.player = player

    warning.warning_end.connect(callable)
    warning.warning_end.connect(free_warning)

    warnings.append(warning)
    add_child(warning)


func spawn_bird(warning: JetpackJoyride.Warning):
    var bird: Node2D = bird_scene.instantiate()
    bird.position = Vector2(warning.position.x + 200, warning.position.y)
    add_child(bird)
    free_on_screen_exit(bird)


func spawn_boulder(warning: JetpackJoyride.Warning):
    var boulder: Node2D = boulder_scene.instantiate()
    boulder.position = Vector2(warning.position.x + 200, warning.position.y)
    add_child(boulder)
    free_on_screen_exit(boulder)


func reset_bird_timer():
    bird_timer.wait_time = randf_range(2, 5)
    bird_timer.start()


func reset_boulder_timer():
    boulder_timer.wait_time = randf_range(4, 8)
    boulder_timer.start()


func free_on_screen_exit(node: Node2D):
    var notifier = VisibleOnScreenNotifier2D.new()
    notifier.screen_exited.connect(Callable(free_object_after).bind(node, 1))
    notifier.position = Vector2.ZERO
    node.add_child(notifier)


func free_object_after(node: Node2D, seconds: float):
    await get_tree().create_timer(seconds).timeout
    node.queue_free()


func free_warning(warning: JetpackJoyride.Warning):
    var index_to_remove = -1
    for i in range(len(warnings)):
        if warnings[i] == warning:
            index_to_remove = i
            break
    if index_to_remove != -1:
        warnings.remove_at(index_to_remove)
        warning.queue_free()


func game_over():
    for warning in warnings:
        warning.queue_free()
    warnings.clear()

    bird_timer.stop()
    boulder_timer.stop()

    var score = (player.position.x - initial_x) / 33.3
    var high_score = Global.session_data.get(SESSION_HIGH_SCORE_KEY, 0.0)

    hud.on_game_over(score, high_score)
    
    if score > high_score:
        high_score = Global.session_data.set(SESSION_HIGH_SCORE_KEY, score)
