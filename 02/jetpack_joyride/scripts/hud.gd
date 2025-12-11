extends Control

@onready var pause_panel: Panel = $PausePanel
@onready var pause_button: Button = $PauseButton
@onready var game_over_panel: Panel = $GameOverPanel
@onready var state_label: Label = $GameOverPanel/Container/StateLabel

func _ready():
    pause_panel.visible = false
    game_over_panel.visible = false

func show_pause(v: bool):
    pause_panel.visible = v

func on_game_over(score: float, high_score: float):
    pause_button.visible = false
    game_over_panel.visible = true
    
    var score_display = ("%.2f" % score) + "M" if score < 1000 else ("%.2f" % (score / 1000)) + "KM"
    var high_score_display = ("%.2f" % high_score) + "M" if high_score < 1000 else ("%.2f" % (high_score / 1000)) + "KM"
    
    if score > high_score:
        state_label.text = "DISTANCE: " + score_display + ("\n!!! RECORD BROKEN !!!" if high_score != 0 else "")
    else:
        state_label.text = "DISTANCE: " + score_display + "\nMAX DISTANCE: " + high_score_display

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
