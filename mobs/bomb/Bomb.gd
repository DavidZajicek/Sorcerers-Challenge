class_name Bomb
extends Mob

func _ready():
	_animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	$ShockArea.connect("body_entered", self, "_on_ShockArea_body_entered")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "will_explode":
		_disable()
		_die_sound.play()
		_animation_player.play("explode")
		if $Shrapnel:
			$Shrapnel.shoot_in_circle()
	elif anim_name == "explode":
		queue_free()
		

func _on_AttackArea_body_entered(body: Robot) -> void:
	body.speed /= 2
	_animation_player.play("will_explode")
	
	yield(get_tree().create_timer(1.0), "timeout")
	body.speed *= 2

func _on_ShockArea_body_entered(body: Node) -> void:
	if not body.has_method("take_damage"):
		return
	body.take_damage(damage)
