extends Control

@onready var weapon_name: LineEdit= %WeaponName;
@onready var weapon: Area3D = %Weapon;

var possible_weapon_names: Dictionary = {};#all possible weapon names
var all_abilities: PackedStringArray = []; #all ability files


func  _ready() -> void:
	get_all_ability_files();
	for ability in all_abilities:
		var sword_ability: SwordAbility = load(ability);
		possible_weapon_names[sword_ability.name.to_lower()] = ability;
		for variation in sword_ability.name_variation:
			possible_weapon_names[variation.to_lower()] = ability;


func get_all_ability_files() -> void:
	var path: String = "res://SwordAbilities/";
	var files: Array= DirAccess.get_files_at(path);
	print(files);
	files = files.filter(func(file:String): return file.begins_with("Ability_"));
	files = files.map(func(file:String): return path+file.trim_suffix(".remap"));
	all_abilities = files;


func _on_weapon_name_text_changed(new_text: String) -> void:
	var key: String = new_text.to_lower();
	var possible_ability = possible_weapon_names.has(key);
	var blade = weapon.sword_blade_parts[0];

	if (possible_ability):
		var ability: SwordAbility = load(possible_weapon_names.get(key));
		
		blade.ability = ability;
		blade.apply_abilities();
		GLOBAL.sword_ability_parts[0] = possible_weapon_names.get(key);
	else:
		if (blade.ability):
			var empty: SwordAbility = load("res://SwordAbilities/Ability_Empty.tres");
			blade.ability = empty;
			blade.apply_abilities();
			GLOBAL.sword_ability_parts[0] = "res://SwordAbilities/Ability_Empty.tres";
		
