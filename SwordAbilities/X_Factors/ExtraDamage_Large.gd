extends XFactor



static func set_passive(user: Creature3D) -> void:
	var extra_damage: float = 200.0;
	user.damage += extra_damage;
	print("added extra damage!");
