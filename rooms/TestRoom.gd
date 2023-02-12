extends YSort

onready var spawner := $Mobs/SpawnerMob

func _ready() -> void:
	spawner.spawn()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
