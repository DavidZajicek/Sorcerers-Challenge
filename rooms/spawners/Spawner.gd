class_name Spawner
extends Sprite

export(Array, PackedScene) var list := []
export(int) var spawn_rate: int = 100
export(int) var spawn_chance: int = 30


func _ready() -> void:
	texture = null
	randomize()

func spawn() -> void:
	if randi() % spawn_rate > spawn_chance:
		return
	if not list:
		return
	
	var random_scene_index := randi() % list.size()
	var scene: PackedScene = list[random_scene_index]
	if not scene:
		return
	var node: Node2D = scene.instance()
	get_parent().add_child(node)
	node.global_position = global_position
