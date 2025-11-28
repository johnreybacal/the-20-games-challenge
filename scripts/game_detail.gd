extends Resource
class_name GameDetail


@export var title: String
@export var description: String
@export var has_p2: bool
@export var scene_path: PackedScene = null

static func make(title: String, description: String, has_p2: bool, scene_path: PackedScene = null) -> GameDetail:
    var g := GameDetail.new()
    g.title = title
    g.description = description
    g.has_p2 = has_p2
    g.scene_path = scene_path
    return g