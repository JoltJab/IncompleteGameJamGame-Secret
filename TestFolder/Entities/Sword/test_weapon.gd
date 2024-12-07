extends Area3D

var hit_things: Array = [];
@export var user: Creature3D;
@export var shape_cast : ShapeCast3D;
@export var sword_blade_parts: Array[Node3D];


var displayed_name: String = "";

signal on_hit(target:Node3D,hit_location:Vector3,status_duration:float,status_name:String);

func _ready() -> void:
	on_hit.connect(on_weapon_hit);
	_deactivate();
	shape_cast.collision_mask = collision_mask;
	
	for i in sword_blade_parts.size():
		if(GLOBAL.sword_ability_parts.size()>i):
			sword_blade_parts[i].ability = load(GLOBAL.sword_ability_parts[i]);
	for i in sword_blade_parts:
		i._ready();

func _activate() -> void:
	monitoring = true;

func _deactivate() -> void:
	hit_things = [];
	monitoring = false;


func _on_body_entered(body: Node3D) -> void:
	
	if(hit_things.find(body) == -1):
		if (body == user): #stop hitting yourself
			return;
		
		hit_things.append(body);
		
		#test balls
		var pos: Vector3 = shape_cast.get_collision_point(0);
		#var ball := MeshInstance3D.new();
		#ball.mesh = SphereMesh.new();
		#get_tree().root.add_child(ball);
		#ball.global_position = pos;
		#print("%s has been hit at global position %s"%[body.name,pos]);
		
		
			
		if (body is Creature3D):
			body.set_health(body.health-user.damage);
		
		for blade in sword_blade_parts:
			on_hit.emit(body,pos,blade.ability.status_duration,blade.ability.name);
		
		
	else: #Creature3D was already hit. Don't hit them again.
		pass;


func on_weapon_hit(target:Node3D,hit_location:Vector3,duration,ability_name) -> void:
	if(target is Creature3D):
		for blade in sword_blade_parts:
			if (blade && blade.ability):
				blade.ability.on_hit(user,target,duration,ability_name);
