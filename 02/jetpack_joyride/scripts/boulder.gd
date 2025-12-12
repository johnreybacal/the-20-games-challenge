extends RigidBody2D

@export var constant_rotation = -360
@export var initial_velocity = Vector2(-300, 0)

@onready var hit_sfx: AudioStreamPlayer = $HitSfx

func _ready():
    linear_velocity = initial_velocity
    body_entered.connect(on_body_entered)

func _physics_process(_delta: float) -> void:
    angular_velocity = deg_to_rad(constant_rotation)

func on_body_entered(body: Node):
    if body is StaticBody2D and body.collision_layer == 2:
        hit_sfx.volume_db -= 1
        hit_sfx.play()
