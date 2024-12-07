extends Node3D

@onready var main_game_room : PackedScene = preload("res://TestFolder/Rooms/test_room.tscn");

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
	get_tree().paused = false;
	
	GLOBAL.sword_ability_parts = ["res://SwordAbilities/Ability_Empty.tres"];

func _on_start_button_button_up() -> void:
	get_tree().change_scene_to_packed(main_game_room);


func _on_weapon_name_text_submitted(new_text: String) -> void:
	get_tree().change_scene_to_packed(main_game_room);
