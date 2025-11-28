extends Node

var has_p2 = false

func quit_to_main_menu(path = "/root/Node"):
    get_tree().paused = false
    get_node(path).queue_free()