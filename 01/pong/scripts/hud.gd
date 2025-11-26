extends Control
class_name Hud

@onready var p1_score: Label = $P1Score
@onready var p2_score: Label = $P2Score
@onready var start_label: Label = $StartLabel
@onready var rally_score: Label = $RallyScore

func _ready():
    set_p1_score(0)
    set_p2_score(0)
    set_rally_score(0)

func set_p1_score(score: int):
    p1_score.text = str(score)

func set_p2_score(score: int):
    p2_score.text = str(score)

func set_rally_score(score: int):
    if score == 0:
        rally_score.visible = false
    else:
        rally_score.visible = true
        rally_score.text = str(score)

func set_start_label_visibility(isVisible: bool):
    start_label.visible = isVisible
