extends CharacterBody2D

@export var run_speed = 300
@export var thrust: float = -500

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: GPUParticles2D = $Particles

var is_flying = false

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("02_jetpack_joyride_click"):
        is_flying = true
    if event.is_action_released("02_jetpack_joyride_click"):
        is_flying = false

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta

    if is_flying:
        velocity.y = lerp(velocity.y, thrust, .1)

    velocity.x = run_speed

    move_and_slide()
    

func _process(_delta: float) -> void:
    play_animation()
    particles.emitting = is_flying

func play_animation():
    if is_on_floor():
        animated_sprite_2d.play("running")
    elif is_flying:
        animated_sprite_2d.play("flying")
    else:
        animated_sprite_2d.play("falling")