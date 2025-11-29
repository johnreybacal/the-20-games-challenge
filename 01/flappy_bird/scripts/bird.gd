extends RigidBody2D
class_name Bird

@export var jump_force: float = -200

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
    animated_sprite_2d.animation_finished.connect(on_animation_finished)

func _process(delta: float):
    if Input.is_action_just_pressed("01_flappy_bird_flap"):
        linear_velocity = Vector2.ZERO
        
        apply_central_impulse(Vector2(0, jump_force))
        animated_sprite_2d.play("flap")
        animated_sprite_2d.rotation = deg_to_rad(-30)

    
    animated_sprite_2d.rotation = rotate_toward(animated_sprite_2d.rotation, deg_to_rad(75), delta * 1.5)
func on_animation_finished():
    if animated_sprite_2d.animation == "flap":
        animated_sprite_2d.play("default")
