extends XFactor


static func on_hit(user: Creature3D,target: Creature3D,duration: float =-1.0,status_name: String = "") -> void:
	status_name += "_damageOverTime";
	
	if (target.statuses.has(status_name)):
		for child in target.get_children():
			if child.name == status_name:
				child.start(duration);
		return;
	
	target.statuses.append(status_name);
	
	
	var timer := Timer.new();
	timer.name = status_name;
	target.add_child(timer);
	timer.start(duration);
	timer.one_shot = true;
	
	
	
	var damage_timer := Timer.new();
	target.add_child(damage_timer);
	damage_timer.start(1);
	damage_timer.one_shot = false;
	
	timer.timeout.connect(status_over.bind(target,status_name,timer,damage_timer));
	damage_timer.timeout.connect(do_damage.bind(target));

static func do_damage(target: Creature3D) -> void:
	var damage_amount: float = 10.0;
	target.set_health(max(0,target.health-damage_amount));
	

static func status_over(target: Creature3D,status_name: String,timer:Timer,damage_timer: Timer):
	target.statuses.erase(status_name);
	if(timer):
		timer.queue_free();
		damage_timer.queue_free();
