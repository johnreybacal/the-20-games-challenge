extends Node

@export var number_textures: Array[CompressedTexture2D] = []

func _ready():
    if len(number_textures) < 10:
        print("error")

func set_value(v: int):
    for child in get_children():
        remove_child(child)
        child.free()

    var number_str = str(v)

    for i in range(len(number_str)):
        var sprite = Sprite2D.new()
        var number = int(number_str[i])
        sprite.texture = number_textures[number]
        sprite.position.x = 25 * i
        add_child(sprite)