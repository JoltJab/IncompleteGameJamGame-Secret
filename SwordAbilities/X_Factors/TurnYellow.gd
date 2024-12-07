extends XFactor


static func on_hit(user: Creature3D,target: Creature3D,duration: float =0.0,status_name: String = "") -> void:
	status_name += "_turnYellow";
	var new_color := Color(0.8,0.8,0.0,1);
	
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
	
	
	timer.timeout.connect(status_over.bind(target,status_name,timer,target_material,new_color));

static func status_over(target: Creature3D,status_name: String,timer:Timer,target_material:BaseMaterial3D,new_color:Color):
	target.statuses.erase(status_name);
	if(timer):
		timer.queue_free();
	if(target_material.albedo_color == new_color):
		target_material.albedo_color = target.default_material.albedo_color;
