extends Area3D

var hit_things: Array = [];
@export var user: Creature3D;
@export var shape_cast : ShapeCast3D;


var displayed_name: String = "";

signal on_hit(target:Node3D,hit_location:Vector3);

func _ready() -> void:
	on_hit.connect(on_weapon_hit);
	_deactivate();
	shape_cast.collision_mask = collision_mask;

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
		
		on_hit.emit(body,pos);
		
		
	else: #Creature3D was already hit. Don't hit them again.
		pass;


func on_weapon_hit(target:Node3D,hit_location:Vector3) -> void:
	if(target is Creature3D):
		pass;
