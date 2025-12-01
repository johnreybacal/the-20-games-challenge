extends Area2D

@export var move_speed = 150
@export var is_p1 = true
@export var is_ai = false

enum PaddlePosition {Top, Middle, Bottom}
var paddle_position = PaddlePosition.Middle
var ai_axis: float = 0

func set_is_ai(ai: bool):
    is_ai = ai

func set_ai_axis(axis: float):
    ai_axis = axis

func _process(delta: float) -> void:
    var axis: float

    if is_ai:
        axis = ai_axis
    else:
        var p1_axis = Input.get_axis("01_pong_p1_up", "01_pong_p1_down")
        var p2_axis = Input.get_axis("01_pong_p2_up", "01_pong_p2_down")

        axis = p1_axis if is_p1 else p2_axis

    if paddle_position == PaddlePosition.Bottom and axis < 0:
        axis = 0
    if paddle_position == PaddlePosition.Top and axis > 0:
        axis = 0

    global_position = Vector2(global_position.x, global_position.y + axis * move_speed * delta)


func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("wall"):
        if global_position.y > area.global_position.y:
            paddle_position = PaddlePosition.Bottom
        else:
            paddle_position = PaddlePosition.Top


func _on_area_exited(area: Area2D) -> void:
    if area.is_in_group("wall"):
        paddle_position = PaddlePosition.Middle
