extends XFactor


static func on_hit(user: Creature3D,target: Creature3D,duration: float =0.0,status_name: String = "") -> void:
	status_name += "_turnRed";
	var new_color := Color(0.821,0.0,0.077,1);
	
	if (target.statuses.has(status_name)):
		for child in target.get_children():
			if child.name == status_name:
				child.start(duration);
		return;
	target.statuses.append(status_name);
	
	
	var target_material: BaseMaterial3D = target.body.mesh.surface_get_material(0);
	
	target_material.albedo_color = new_color;
	
	var timer := Timer.new();
	timer.name = status_name;
	target.add_child(timer);
	timer.start(duration);
	timer.one_shot = true;
	
	
	await timer.timeout;
	
	target.statuses.erase(status_name);
	if(timer):
		timer.queue_free();
	if(target_material.albedo_color == new_color):
		target_material.albedo_color = target.default_material.albedo_color;
