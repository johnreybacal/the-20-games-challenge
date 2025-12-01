extends Area2D

signal scored(player: int)

func _on_area_exited(area: Area2D) -> void:
    if area.is_in_group("ball"):
        var ball: Pong.Ball = area as Pong.Ball
        if ball.is_in_play:
            if global_position.x > area.global_position.x:
                scored.emit(2)
            else:
                scored.emit(1)

        area.queue_free()
