extends Node

@export var player: FlappyBird.Bird
@export var hud: FlappyBird.Hud
@export var pipe_scene: PackedScene
@export var pipe_move_speed: float = 100
@export var interval = 1.5
var timer = interval
var spawn_x = 450
var spawn_y_min = -125
var spawn_y_max = 125
var is_playing = false
var score = 0

var pipes: Array[Node2D] = []

func _ready():
    if player:
        player.on_first_flap.connect(on_start)
        player.on_score.connect(on_score)
        player.on_game_over.connect(on_game_over)
    hud.init()

func _process(delta: float) -> void:
    if not is_playing:
        return

    timer += delta

    if timer >= interval:
        timer = 0
        var pipe: Node2D = pipe_scene.instantiate()
        var spawn_y = randf_range(spawn_y_min, spawn_y_max)
        pipe.position = Vector2(spawn_x, spawn_y)
        add_child(pipe)
        pipes.append(pipe)

    var remove_pipe_index = -1

    for index in range(len(pipes)):
        var pipe = pipes[index]
        pipe.position = Vector2(pipe.position.x - (pipe_move_speed * delta), pipe.position.y)

        if pipe.position.x < -450:
            remove_pipe_index = index

    if remove_pipe_index >= 0:
        pipes[remove_pipe_index].queue_free()
        pipes.remove_at(remove_pipe_index)

func on_start():
    is_playing = true
    hud.set_start_message_visibility(false)

func on_game_over():
    is_playing = false
    hud.set_game_over_message_visibility(true)
    
    for node in get_tree().get_nodes_in_group("score_area"):
        call_deferred("disable_collision_of_node", node)
    

func on_score():
    score += 1
    hud.set_score(score)

func disable_collision_of_node(node: Node):
    (node.get_node("CollisionShape2D") as CollisionShape2D).disabled = true
