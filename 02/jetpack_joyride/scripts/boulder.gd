extends RigidBody2D

@export var constant_rotation = -360
@export var initial_velocity = Vector2(-300, 0)

func _ready():
    linear_velocity = initial_velocity

func _physics_process(_delta: float) -> void:
    angular_velocity = deg_to_rad(constant_rotation)