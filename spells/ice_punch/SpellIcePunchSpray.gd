class_name SpellIcePunchSpray
extends Spell

export var pellets : int = 5

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and _cooldown_timer.is_stopped():
		shoot()

func shoot() -> void:
	_cooldown_timer.start()
	for pellet in pellets:
		.shoot()
