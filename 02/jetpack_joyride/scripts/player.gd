extends CharacterBody2D

@export var run_speed: float = 300
@export var thrust: float = -500

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: GPUParticles2D = $Particles

signal died()

var is_flying = false
var is_playing = true
var is_dying = false

func _input(event: InputEvent) -> void:
    if not is_playing:
        return
    if event.is_action_pressed("02_jetpack_joyride_click"):
        is_flying = true
    if event.is_action_released("02_jetpack_joyride_click"):
        is_flying = false

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta

    if is_playing:
        if is_flying:
            velocity.y = lerp(velocity.y, thrust, .1)
            
        velocity.x = run_speed
    else:
        if is_on_floor():
            velocity.x = lerp(velocity.x, 0.0, 0.025)

    for i in get_slide_collision_count():
        var collision = get_slide_collision(i)
        var collider: Node2D = collision.get_collider()
        if collider.is_in_group("obstacle"):
            collider.collision_mask = 0
            collider.collision_layer = 0
            if is_playing:
                is_playing = false
                is_flying = false
                is_dying = true
                died.emit()
            break

    move_and_slide()


func _process(_delta: float) -> void:
    play_animation()
    particles.emitting = is_flying

func play_animation():
    if is_playing:
        if is_on_floor():
            animated_sprite_2d.play("running")
        elif is_flying:
            animated_sprite_2d.play("flying")
        else:
            animated_sprite_2d.play("falling")
    if is_dying:
        if is_on_floor():
            is_dying = false
            animated_sprite_2d.play("died")
        else:
            animated_sprite_2d.play("die")
