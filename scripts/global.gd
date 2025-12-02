extends Node

var has_p2 = false
var session_data = {}

func quit_to_main_menu():
    if get_tree().paused:
        get_tree().paused = false
    get_tree().change_scene_to_file("res://scenes/main_menu.tscn")