extends XFactor



static func set_passive(user: Creature3D) -> void:
	var extra_damage: float = 10;
	user.damage += extra_damage;
