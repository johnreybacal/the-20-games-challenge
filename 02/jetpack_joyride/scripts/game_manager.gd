extends Node2D

@onready var bird_timer: Timer = $BirdTimer
@onready var boulder_timer: Timer = $BoulderTimer
@onready var run_timer: Timer = $RunTimer

@export var player: JetpackJoyride.Player
@export var warning_scene: PackedScene
@export var bird_scene: PackedScene
@export var boulder_scene: PackedScene

var warnings: Array[JetpackJoyride.Warning] = []
var initial_x


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

func spawn_boulder(warning: JetpackJoyride.Warning):
    var boulder: Node2D = boulder_scene.instantiate()
    boulder.position = Vector2(warning.position.x + 200, warning.position.y)
    add_child(boulder)

func reset_bird_timer():
    bird_timer.wait_time = randf_range(2, 5)
    bird_timer.start()

func reset_boulder_timer():
    boulder_timer.wait_time = randf_range(4, 8)
    boulder_timer.start()

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
    print(player.position.x - initial_x)
