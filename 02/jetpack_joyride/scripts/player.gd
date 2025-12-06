extends CharacterBody2D

@export var gravity = 9.8
@export var run_speed = 300
@export var thrust: float = -500

var is_flying = false

func _input(event: InputEvent) -> void:
    is_flying = event.is_action("02_jetpack_joyride_click")

func _physics_process(_delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity

    if is_flying:
        velocity.y = lerp(velocity.y, thrust, .1)

    velocity.x = run_speed

    move_and_slide()
