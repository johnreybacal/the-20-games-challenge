extends Control

@onready var p1_score: Label = $P1Score
@onready var p2_score: Label = $P2Score
@onready var start_label: Label = $StartLabel
@onready var rally_score: Label = $RallyScore
@onready var pause_label: Label = $PauseLabel
@onready var paused_label: Label = $PausedLabel

var p1_movement = "Move P1 with W and S\n"
var p2_movement = "\n"
var start_instruction = "Press space to start\n"
var pause_instruction = "Press space to pause\n"
var reset_instruction = "Press R to reset\n"
var quit_instruction = "Press esc to quit\n"

func _ready():
    init()
    if Global.has_p2:
        p2_movement = "Move P2 with Up and Down\n\n"
    
func init():
    set_p1_score(0)
    set_p2_score(0)
    set_rally_score(0)
    start_label.visible = true
    pause_label.visible = false
    paused_label.visible = false
    start_label.text = p1_movement + p2_movement + start_instruction + quit_instruction


func set_p1_score(score: int):
    p1_score.text = str(score)

func set_p2_score(score: int):
    p2_score.text = str(score)

func add_reset_to_start_label():
    start_label.text = p1_movement + p2_movement + start_instruction + reset_instruction + quit_instruction

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
