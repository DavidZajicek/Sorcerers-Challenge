extends Mob

onready var _raycast := $RayCast2D

var target_position : Vector2
var lunging : bool = false

func _prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	lunging = true
	_before_attack_timer.start()
	target_position = _target.global_position

func _on_BeforeAttackTimer_timeout() -> void:
	lunge_to_position()

func _physics_process(delta: float) -> void:
	if not _target:
		return
	_raycast.look_at(_target.global_position)
	_raycast.force_raycast_update()
	
	if _before_attack_timer.is_stopped() and not lunging:
		orbit_target()
		if _raycast.get_collider() == _target:
			if _target_within_range:
				_prepare_to_attack()
			else:
				follow(_target.global_position)

func lunge_to_position() -> void:
	_drag_factor = 1.0
	follow(target_position)
	if position.distance_to(target_position) < 5.0:
		lunging = false
		_drag_factor = 6.0
		target_position = Vector2.ZERO

func orbit_target() -> void:
	if not _target:
		return
	var direction := _target.global_position.direction_to(global_position)
	var offset_from_target := direction.rotated(PI / 6.0) * orbit_distance
	follow(_target.global_position + offset_from_target)
	$Sprite.rotation = direction.rotated(PI).angle()
