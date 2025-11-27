extends Area2D
class_name Ball
@export var speed = 100
@export var direction = Vector2(1, 1)

@onready var hit_sound: AudioStreamPlayer2D = $HitSound

signal on_paddle_hit()

var is_in_play = false

func _process(delta: float) -> void:
    if is_in_play:
        direction = direction.normalized()
        var toward = Vector2(speed * direction.x * delta, speed * direction.y * delta)
        global_position = Vector2(global_position.x + toward.x, global_position.y + toward.y)


func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("wall"):
        direction = Vector2(direction.x, direction.y * -1)
        play_hit_sound()
    if area.is_in_group("paddle"):
        var directionX = direction.x * -1
        direction = Vector2(randf_range(directionX - 0.25, directionX + 0.25), randf_range(direction.y - 0.25, direction.y + 0.25))
        speed += 10
        play_hit_sound()
        on_paddle_hit.emit()


func play_hit_sound():
    hit_sound.pitch_scale = randf_range(0.75, 1.25)
    hit_sound.play()
