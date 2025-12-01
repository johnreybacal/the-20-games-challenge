extends RigidBody2D

@export var jump_force: float = -200

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var flap_sfx: AudioStreamPlayer2D = $SFX/Flap
@onready var die_sfx: AudioStreamPlayer2D = $SFX/Die
@onready var hit_sfx: AudioStreamPlayer2D = $SFX/Hit
@onready var point_sfx: AudioStreamPlayer2D = $SFX/Point

var is_playing = false
var is_first_flap = true

signal on_game_over()
signal on_first_flap()
signal on_score()

func _ready():
    freeze = true
    body_entered.connect(_on_body_entered)
    animated_sprite_2d.animation_finished.connect(on_animation_finished)

func _process(delta: float):
    if not is_playing:
        if Input.is_action_just_pressed("01_flappy_bird_flap") and is_first_flap:
            on_first_flap.emit()
            is_playing = true
            is_first_flap = false
            freeze = false
            flap()
        return
    if Input.is_action_just_pressed("01_flappy_bird_flap"):
        flap()

    animated_sprite_2d.rotation = rotate_toward(animated_sprite_2d.rotation, deg_to_rad(75), delta * 1.5)

func flap():
    linear_velocity = Vector2.ZERO
        
    apply_central_impulse(Vector2(0, jump_force))
    animated_sprite_2d.play("flap")
    animated_sprite_2d.rotation = deg_to_rad(-30)
    flap_sfx.pitch_scale = randf_range(0.75, 1.25)
    flap_sfx.play()


func on_animation_finished():
    if animated_sprite_2d.animation == "flap":
        animated_sprite_2d.play("default")

func _on_body_entered(body: Node) -> void:
    if body.is_in_group("obstacle") and is_playing:
        is_playing = false
        on_game_over.emit()
        die_sfx.play()
        linear_velocity = Vector2(125, linear_velocity.y)
        angular_velocity = 10
    if body.is_in_group("floor"):
        # Can't disable contact monitoring during in/out callback. Use call_deferred("set_contact_monitor", false) instead
        # contact_monitor = false
        max_contacts_reported = 0
        die_sfx.stop()
        hit_sfx.play()
    if body.is_in_group("score_area"):
        call_deferred("disable_collision_of_body", body)
        on_score.emit()
        point_sfx.play()

func disable_collision_of_body(body: Node):
    (body.get_node("CollisionShape2D") as CollisionShape2D).disabled = true
