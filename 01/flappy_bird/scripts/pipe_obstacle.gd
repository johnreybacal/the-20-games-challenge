extends Node2D
class_name PipeObstacle

@export var move_speed = 100

@onready var top_area: Area2D = $PipeTop/Area2D
@onready var bottom_area: Area2D = $PipeBottom/Area2D
@onready var score_area: Area2D = $ScoreArea

func _ready():
    top_area.body_entered.connect(on_obstacle_hit)
    bottom_area.body_entered.connect(on_obstacle_hit)

    score_area.body_entered.connect(on_score)

func _process(delta: float):
    position = Vector2(position.x - (move_speed * delta), position.y)

    if position.x < -450:
        queue_free()


func on_obstacle_hit(body: Node2D):
    if body.is_in_group("player"):
        print("game over")

func on_score(body: Node2D):
    if body.is_in_group("player"):
        print("score")