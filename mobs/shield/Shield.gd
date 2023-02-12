extends Mob

export(int) var _spray: int = 3

onready var _cannon := $Cannon
onready var _raycast := $RayCast2D



func _prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	_before_attack_timer.start()

func _on_BeforeAttackTimer_timeout() -> void:
	if not _target:
		return
	for i in _spray:
		_cannon.shoot_at_target(_target)
	_cooldown_timer.start()

func _physics_process(delta: float) -> void:
	if not _target:
		return
	_cannon.look_at(_target.global_position)
	_raycast.look_at(_target.global_position)
	_raycast.force_raycast_update()
	
	orbit_target()
	if _raycast.get_collider() == _target:
		if _target_within_range:
			_prepare_to_attack()
		else:
			follow(_target.global_position)

func _on_DetectionArea_body_exited(_body: Robot) -> void:
	pass

