class_name Creature3D extends CharacterBody3D

@export_group("Creature Attributes")
@export var body: MeshInstance3D;
@export var weapon: Area3D;
@export var speed: float = 10.0;
@export var jump_velocity: float = 10.0;
@export var max_health: float = 100.0;
@export var damage: float = 10.0;


var statuses : Array[String]; #list of all currently applied status effects

var health: float;

var default_speed: float;
var default_jump_velocity: float;
var default_max_health: float;
var default_damage: float;
var default_material: Material;


signal health_changed(new_health:float);
signal max_health_changed(new_max_health:float);
signal zero_health();


signal damage_changed(new_damage:float);


func set_stats()-> void:
	default_speed = speed;
	default_jump_velocity = jump_velocity;
	default_max_health = max_health;
	default_damage = damage;
	
	health = max_health;
	
	health_changed.emit(health);
	max_health_changed.emit(max_health);



func set_health(new_health: float=0)-> void:
	if(new_health<health): #took damage
		pass;
	elif(new_health>health): #healed
		pass;
	else: #no change
		pass;
	
	health_changed.emit(new_health);
	if new_health <= 0:
		zero_health.emit();
	
	health = clamp(new_health,0,max_health);


func set_max_health(new_max_health: float=0)-> void:
	if(new_max_health<max_health): #took damage
		pass;
	elif(new_max_health>max_health): #healed
		pass;
	else: #no change
		pass;
	
	max_health_changed.emit(new_max_health);

	max_health = new_max_health;


func set_damage(new_damage: float=0.0)-> void:
	if(new_damage<damage): #decrease damage
		pass;
	elif(new_damage>damage): #increase damage
		pass;
	else: #no change
		pass;
	
	damage_changed.emit(new_damage);
	damage = new_damage;
