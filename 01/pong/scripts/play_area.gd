extends Area2D
class_name PlayArea

signal scored(player: int)

func _on_area_exited(area: Area2D) -> void:
    if area.is_in_group("ball"):
        if global_position.x > area.global_position.x:
            scored.emit(2)
        else:
            scored.emit(1)
                
        area.queue_free()
