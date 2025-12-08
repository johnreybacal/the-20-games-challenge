extends Node2D

@onready var bird_timer: Timer = $BirdTimer
@onready var run_timer: Timer = $RunTimer

@export var player: JetpackJoyride.Player
@export var warning_scene: PackedScene
@export var bird_scene: PackedScene

var warnings: Array[JetpackJoyride.Warning] = []
var initial_x

func _ready():
    bird_timer.timeout.connect(spawn_bird_warning)
    bird_timer.start()
    run_timer.timeout.connect(increase_speed)
    player.died.connect(game_over)
    initial_x = player.position.x

func increase_speed():
    player.run_speed += 10

func reset_bird_timer():
    bird_timer.wait_time = randf_range(0, 2)
    bird_timer.start()

func spawn_bird_warning():
    var warning: JetpackJoyride.Warning = warning_scene.instantiate()
    var y = randf_range(player.position.y - 150, player.position.y + 150)
    y = clampf(y, -333, 269)
    warning.position = Vector2(player.position.x + 1100, y)
    warning.player = player
    warning.warning_end.connect(spawn_bird)
    warnings.append(warning)
    add_child(warning)
    reset_bird_timer()

func spawn_bird(warning: JetpackJoyride.Warning):
    var bird: Node2D = bird_scene.instantiate()
    bird.position = Vector2(warning.position.x + 200, warning.position.y)
    add_child(bird)

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
    for node in get_tree().get_nodes_in_group("obstacle"):
        (node as PhysicsBody2D).collision_layer = 0
        (node as PhysicsBody2D).collision_mask = 0
    bird_timer.stop()
    print(player.position.x - initial_x)
