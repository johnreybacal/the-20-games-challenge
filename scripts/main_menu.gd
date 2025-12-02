extends Control
class_name MainMenu

@onready var game_list: ItemList = $VBoxContainer/HBoxContainer/GameList
@onready var title: Label = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Title
@onready var description: Label = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/Description
@onready var p2_checkbox: CheckBox = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/P2Checkbox
@onready var play_button: Button = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/PlayButton

var game_details: Array[GameDetail] = [
        GameDetail.make(
            "Pong",
            "Pong was the first widely successful arcade game. It was released in 1972, and started the first arcade boom. The game may seem simple today, but it was designed directly in hardware. Essentially, Pong was a specialized computer designed to bounce a ball between two paddles and keep score.",
            true,
            "res://01/pong/scenes/game.tscn"
        ),
        GameDetail.make(
            "Flappy Bird",
            "Flappy bird was a mobile game from 2013. It was a sleeper hit, gaining sudden and massive popularity in 2014, likely due to attention from a popular YouTuber at that time. The game was removed from the App store after it’s sudden popularity due to negative media attention.",
            false,
            "res://01/flappy_bird/scenes/game.tscn"
        )
    ]

func _ready():
    var selected_game_index = Global.selected_game_index
    game_list.item_selected.connect(on_game_selected)
    game_list.select(selected_game_index)
    on_game_selected(selected_game_index)
    p2_checkbox.button_pressed = Global.has_p2

func on_game_selected(index: int):
    Global.selected_game_index = index
    var game_detail = game_details[index]
    title.text = game_detail.title
    description.text = game_detail.description
    p2_checkbox.visible = game_detail.has_p2

func on_game_start():
    var selected = game_list.get_selected_items()
    
    var game_detail = game_details[selected.get(0)]

    if game_detail.scene_path:
        Global.has_p2 = p2_checkbox.button_pressed
        get_tree().change_scene_to_file(game_detail.scene_path)
