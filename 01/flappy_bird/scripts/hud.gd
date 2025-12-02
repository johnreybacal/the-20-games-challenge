extends Control

@onready var start_message: CenterContainer = $StartMessage
@onready var game_over_panel: VBoxContainer = $GameOverPanel
@onready var game_over_animation_player: AnimationPlayer = $GameOverPanel/AnimationPlayer
@onready var counter: FlappyBird.Counter = $Counter

signal on_restart()

func _ready():
    init()
    
func init():
    set_start_message_visibility(true)
    set_game_over_panel_visibility(false)
    set_score(0)

func set_start_message_visibility(is_visible: bool):
    start_message.visible = is_visible

func set_game_over_panel_visibility(is_visible: bool):
    if is_visible:
        game_over_animation_player.play("RESET")
    game_over_panel.visible = is_visible

func set_score(score: int):
    counter.set_value(score)


func _on_restart_button_pressed() -> void:
    on_restart.emit()
