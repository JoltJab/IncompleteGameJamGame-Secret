extends Node3D


@onready var game_start_screen: PackedScene = load("res://TestFolder/Rooms/GameStartScreen.tscn");
@onready var test_room: PackedScene = load("res://TestFolder/Rooms/test_room.tscn")
@onready var player: Creature3D = %Player;
@onready var enemy: Creature3D = %Enemy;

@export_category("menus")
@export var healthBarUI: Control;
@export var pauseMenu: Control;

signal paused(is_paused:bool);

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	
func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("KEY_ESCAPE")):
		pause();

	if(Input.is_key_pressed(KEY_R)):
		room_end();
		get_tree().change_scene_to_packed(test_room);



func pause () -> void:
	if(get_tree().is_paused()):	#unpausing screen
		healthBarUI.visible=true;
		pauseMenu.visible=false;
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
		get_tree().paused = false;
		paused.emit(false);
		
	else:
		healthBarUI.visible=false;
		pauseMenu.visible=true;
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
		get_tree().paused = true;
		paused.emit(true);


func _physics_process(delta: float) -> void:
	get_tree().call_group("Enemies","update_target_location",player.global_position);
	

func _player_died() -> void:
	get_tree().reload_current_scene.call_deferred();
	
func _boss_died() -> void:
	get_tree().reload_current_scene.call_deferred();


func _on_continue_button_up() -> void:
	pause();


func _on_options_button_up() -> void:
	pass; # Replace with function body.


func _on_main_menu_button_up() -> void:
	get_tree().paused=false;
	room_end();
	get_tree().change_scene_to_packed(game_start_screen);
	
	
	
func room_end() -> void:
	enemy.body.mesh.surface_set_material(0,enemy.default_material);
	player.body.mesh.surface_set_material(0,player.default_material);
	#for blade in player.weapon.sword_blade_parts:
		#blade.SwordAbility = load("res://SwordAbilities/Ability_Empty.tres");
