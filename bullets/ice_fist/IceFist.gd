extends Bullet

export var acceleration := 100.0

onready var _animation_player := $AnimationPlayer as AnimationPlayer
onready var _ice_splash_particles := $IceSplashParticles2D as Particles2D

var current_speed : float

func _ready() -> void:
	_animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	_animation_player.play("spawn")

func _move(delta: float) -> void:
	if current_speed < speed:
		current_speed += acceleration
	var distance := current_speed * delta
	var motion := transform.x * current_speed * delta

	position += motion

	_travelled_distance += distance
	if _travelled_distance > max_range:
		_destroy()

func _destroy():
	_disable()
	_audio.play()
	_animation_player.play("destroy")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "destroy":
		queue_free()
