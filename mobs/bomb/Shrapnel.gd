extends Position2D

# The cannon can target either the player or mobs. Since the cannon is supposed
# to be used by mobs, it defaults to the player.
enum CollisionMask {
	PLAYER = 1,
	MOB = 2,
	BOTH = 3
}


# Load a bullet scene to shoot here
export var BulletScene: PackedScene

# Decides what collision mask the next ejected bullet will be
export(CollisionMask) var collision_mask := CollisionMask.PLAYER

# Maximum distance a bullet can travel before it disappears.
export(float, 100.0, 2000.0, 1.0) var max_range := 2000.0
# The speed of the shot bullets.
export(float, 100.0, 3000.0, 1.0) var bullet_speed := 400.0

export var shots := 10

# Shoots the bullet in direction of the provided target
func shoot_in_circle() -> void:
	for shot in shots:
		var bullet: Bullet = BulletScene.instance()
		bullet.global_transform = self.global_transform
		bullet.max_range = max_range
		bullet.speed = bullet_speed
		bullet.collision_mask = collision_mask
		bullet.set_collision_mask_bit(4, true)
		bullet.rotation_degrees = (shot+1) * (360 / shots )
		get_tree().root.add_child(bullet)
