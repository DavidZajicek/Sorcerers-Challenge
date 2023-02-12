## Takes care of showing the UI. Should be always present. Uses the global Events
## autoload to know when to update
extends Control
var _score: = 0 setget _set_score

onready var _health_bar: = $HealthBar
onready var _score_label: = $ScoreLabel

func _ready() -> void:
	_set_score(0)
	
	Events.connect("mob_died", self, "_on_Events_mob_died")
	Events.connect("player_health_changed", self, "_on_Events_player_health_changed")

func _set_score(new_score: int) -> void:
	_score = new_score
	_score_label.text = str(_score).pad_zeros(5)

func _on_Events_mob_died(mob_score_value: int) -> void:
	_set_score(_score + mob_score_value)

func _on_Events_player_health_changed(health: int) -> void:
	_health_bar.health = health
