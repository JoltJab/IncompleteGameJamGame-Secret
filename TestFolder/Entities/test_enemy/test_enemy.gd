extends Creature3D
@export var nav_agent: NavigationAgent3D;

@onready var look_at_target: Vector3 = nav_agent.target_position;
@onready var look_at_target_old: Vector3 = nav_agent.target_position;



func _ready() -> void:
	default_material = body.mesh.surface_get_material(0).duplicate(true);
	set_stats();
	
	#Wait for "first map synchronization", whatever that is.
	set_physics_process(false);
	NavigationServer3D.map_changed.connect(
		func (map: RID):
			if map == nav_agent.get_navigation_map():
				set_physics_process(true);
	)

func _physics_process(delta: float) -> void:
	
	
	var current_location = global_position;
	var next_location = nav_agent.get_next_path_position();
	
	var distance: Vector3 = (nav_agent.target_position-current_location);
	var new_velocity: Vector3;
	if(distance.length() > nav_agent.target_desired_distance):
		new_velocity = (next_location - current_location).normalized() * speed * delta;
		
		weapon.hit_things = [];
		
		if (weapon.monitoring):
			weapon._deactivate();
		
	else:
		new_velocity = (current_location-next_location).normalized() * max(0,speed) * delta;
		if (!weapon.monitoring):
			weapon._activate();

	velocity = velocity.move_toward(new_velocity,1);
		
	
	look_at_target = lerp(look_at_target_old,nav_agent.target_position,clamp(speed/default_speed,0,1))
	body.look_at(look_at_target);
	look_at_target_old = look_at_target;
	move_and_slide();


func update_target_location(target_location: Vector3)->void:
	nav_agent.target_position = target_location;
