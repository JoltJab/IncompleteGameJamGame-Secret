class_name SwordAbility extends Resource
#resource class

@export var name: String;
@export var name_variation: PackedStringArray;
@export var blade: Mesh;
@export var material: StandardMaterial3D;
@export var particleEffects: PackedScene;
@export var bumpy: PackedScene;
@export var xFactor: Array[Script];
@export var status_duration: float = -1.0;

@export_group("Sound")
@export var default: AudioStream;
@export var swing: AudioStream;
@export var hit: AudioStream;


func set_passive(user: Creature3D) -> void:
	for script in xFactor:
		if (script):
			script.set_passive(user);
		

func on_hit(user: Creature3D,target: Creature3D,duration: float,name_of_status: String) -> void:
	for script in xFactor:
		if (script):
			script.on_hit(user,target,status_duration,name);
		
func attack_start(user: Creature3D) -> void:
	for script in xFactor:
		if (script):
			script.attack_start(user);
		
func attack_end(user: Creature3D) -> void:
	for script in xFactor:
		if (script):
			script.attack_end(user);
		

func on_receive_hit(user: Creature3D, attacker: Creature3D) -> void:
	for script in xFactor:
		if (script):
			script.on_receive_hit(user,attacker);
