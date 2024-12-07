extends Node3D

@export var user: Creature3D;
@export var ability :SwordAbility;
@onready var blade_part: MeshInstance3D = %BladePart;
@onready var bumpy_locations: Node3D = %BumpyLocations;

@onready var default_surface_material : StandardMaterial3D = blade_part.mesh.surface_get_material(0);


func _ready() -> void:
	if (!ability):
		return;
	apply_abilities();
	ability.set_passive(user);
	


func apply_abilities() -> void:	
	if(ability.blade != null):
		blade_part.mesh = ability.blade;
	
	if(ability.material != null):
		blade_part.mesh.surface_set_material(0,ability.material);
	
	#remove any existing particle effects before adding new ones
	for child in get_children():
		if (child != blade_part && child != bumpy_locations):
			child.queue_free();
	#add particle effects
	if(ability.particleEffects != null):
		add_child(ability.particleEffects.instantiate());

	#remove any current bumpys before adding new ones
	for marker in bumpy_locations.get_children():
		for bump in marker.get_children():
			bump.queue_free();
	#add new bumpys
	if(ability.bumpy != null):
		for marker in bumpy_locations.get_children():
			var bumpy :Node3D = ability.bumpy.instantiate();
			marker.add_child(bumpy);
			bumpy.position = Vector3.ZERO;
			bumpy.rotation = Vector3.ZERO;
			bumpy.scale = Vector3.ONE;
		
