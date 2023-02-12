extends YSort

# The list of possible rooms to spawn
export(Array, PackedScene) var rooms := []
# The number of rooms on the x-axis
export var grid_width := 2
# The number of rooms on the y-axis
export var grid_height := 2
# The size of each individual room. It's assumed that all the rooms in the
# rooms array have that size.
export var room_size := Vector2(13, 13) * 128

onready var pause_screen: = $UILayer/PauseScreen

func _ready():
	randomize()
	generate_level()

func generate_level() -> void:
	for x in grid_width:
		for y in grid_height:
			var random_room_index := randi() % rooms.size()
			var room: PackedScene = rooms[random_room_index]
			if not room:
				return
			
			var room_instance: BaseRoom = room.instance()
			add_child(room_instance)
			room_instance.global_position = Vector2(x * room_size.x, y * room_size.y)
			
			if x == 0 and y == 0:
				room_instance.spawn_robot()
			else:
				room_instance.spawn_mobs()
				room_instance.spawn_items()
			if x == grid_width -1 and y == grid_height -1:
				room_instance.spawn_teleporter()
			if x == 0:
				room_instance.hide_left_bridge()
			if y == 0:
				room_instance.hide_top_bridge()
			if x == grid_width - 1:
				room_instance.hide_right_bridge()
			if y == grid_height - 1:
				room_instance.hide_bottom_bridge()



