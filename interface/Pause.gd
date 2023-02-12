# The pause screen. It should exist in the main game scene but start hidden.
#
# Pressing the "pause" input action will show this screen and pause everything
# else.
extends Control

onready var _button_continue := $CenterContainer/VBoxContainer/ContinueButton
onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton

func _ready() -> void:
	_button_continue.connect("pressed", self, "toggle_pause")
	_button_restart.connect("pressed", self, "restart")
	_button_quit.connect("pressed", self, "quit")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause_toggle"):
		toggle_pause()

func toggle_pause() -> void:
	if not visible:
		show()
	else:
		hide()
	get_tree().paused = visible

func restart() -> void:
	get_tree().reload_current_scene()
	hide()
	get_tree().paused = visible

func quit() -> void:
	get_tree().quit()
