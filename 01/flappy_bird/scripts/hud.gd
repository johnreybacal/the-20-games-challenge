extends Control

@onready var start_message: CenterContainer = $StartMessage
@onready var game_over_mesage: CenterContainer = $GameOverMesage
@onready var counter: FlappyBird.Counter = $Counter

func _ready():
    init()
    
func init():
    set_start_message_visibility(true)
    set_game_over_message_visibility(false)
    set_score(0)

func set_start_message_visibility(is_visible: bool):
    start_message.visible = is_visible

func set_game_over_message_visibility(is_visible: bool):
    game_over_mesage.visible = is_visible

func set_score(score: int):
    counter.set_value(score)