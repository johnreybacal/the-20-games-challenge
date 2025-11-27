extends Control
class_name Hud

@onready var p1_score: Label = $P1Score
@onready var p2_score: Label = $P2Score
@onready var start_label: Label = $StartLabel
@onready var rally_score: Label = $RallyScore
@onready var pause_label: Label = $PauseLabel
@onready var paused_label: Label = $PausedLabel

func _ready():
    init()
    
func init():
    set_p1_score(0)
    set_p2_score(0)
    set_rally_score(0)
    start_label.visible = true
    pause_label.visible = false
    paused_label.visible = false
    start_label.text = "Move P1 with W and S\nMove P2 with Up and Down\n\nPress space to start"


func set_p1_score(score: int):
    p1_score.text = str(score)

func set_p2_score(score: int):
    p2_score.text = str(score)

func add_reset_to_start_label():
    print("Adding reset to start label")
    start_label.text = "Move P1 with W and S\nMove P2 with Up and Down\n\nPress space to start\n\nPress R to reset"

func set_rally_score(score: int):
    if score == 0:
        rally_score.visible = false
    else:
        rally_score.visible = true
        rally_score.text = str(score)

func set_start_label_visibility(isVisible: bool):
    start_label.visible = isVisible
    if isVisible:
        pause_label.visible = false

func toggle_paused(is_paused: bool):
    pause_label.visible = !is_paused
    paused_label.visible = is_paused
