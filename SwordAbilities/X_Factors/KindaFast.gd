extends XFactor


static func on_hit(user: Creature3D,target: Creature3D,duration: float =-1.0,status_name: String = "") -> void:
	status_name += "_kindaFast";
	
	if (target.statuses.has(status_name)):
		for child in target.get_children():
			if child.name == status_name:
				child.start(duration);
		return;
	
	target.statuses.append(status_name);
	
	var speed_change: float = target.speed*1.25;
	
	target.speed += speed_change;
	
	var timer := Timer.new();
	timer.name = status_name;
	target.add_child(timer);
	timer.start(duration);
	timer.one_shot = true;
	
	
	timer.timeout.connect(status_over.bind(target,status_name,timer,speed_change));
	
	


static func status_over(target: Creature3D,status_name: String,timer:Timer,speed_change:float):
	target.statuses.erase(status_name);
	if(timer):
		timer.queue_free();
	target.speed -= speed_change;
