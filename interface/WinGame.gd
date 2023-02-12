extends Control

export(PackedScene) var main

onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton

func _ready() -> void:
	_button_restart.connect("pressed", self, "restart")
	_button_quit.connect("pressed", self, "quit")


func restart() -> void:
	get_tree().change_scene_to(main)
	hide()
	get_tree().paused = visible

func quit() -> void:
	get_tree().quit()
