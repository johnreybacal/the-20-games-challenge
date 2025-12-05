extends Control

@onready var life_label: Label = $LifeLabel
@onready var score_label: Label = $ScoreLabel
@onready var high_score_label: Label = $HighScoreLabel

@onready var pause_container: VBoxContainer = $PauseContainer
@onready var pause_button: Button = $PauseButton

@onready var game_over_container: VBoxContainer = $GameOverContainer
@onready var state_label: Label = $GameOverContainer/StateLabel

func _ready():
    pause_container.visible = false
    game_over_container.visible = false

func show_pause(v: bool):
    pause_container.visible = v

func on_game_over(is_winner: bool):
    pause_button.visible = false
    game_over_container.visible = true
    state_label.text = "YOU WON!" if is_winner else "YOU LOST."

func set_life(value: int):
    life_label.text = "BALLS: " + str(value)

func set_score(value: int):
    score_label.text = "SCORE: " + str(value)

func set_high_score(value: int):
    high_score_label.text = "HIGH SCORE: " + str(value)

func _on_quit_button_button_down() -> void:
    Global.quit_to_main_menu()

func _on_restart_button_button_down() -> void:
    get_tree().reload_current_scene()

func _on_pause_button_button_down() -> void:
    show_pause(true)
    get_tree().paused = true
    pause_button.visible = false

func _on_resume_button_button_down() -> void:
    show_pause(false)
    get_tree().paused = false
    pause_button.visible = true
