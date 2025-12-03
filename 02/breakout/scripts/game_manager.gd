extends Node

@export var colors: Array[Color] = ["#92140C", "#BE5A38", "#BE7C4D"]
@export var brick_scene: PackedScene


func _ready():
    var pos_x = -152
    var pos_y = -70
    for row in range(3):
        var x = pos_x
        for col in range(20):
            var brick: Node2D = brick_scene.instantiate()
            brick.position = Vector2(x, pos_y)
            brick.modulate = colors[row]
            add_child(brick)
            x += 16
        pos_y += 6.5
