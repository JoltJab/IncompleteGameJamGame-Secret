extends Control


@onready var sword_name_room : PackedScene = preload("res://TestFolder/Rooms/SwordNameRoom.tscn");

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
	get_tree().paused = false;

func _on_start_button_up() -> void:
	get_tree().change_scene_to_packed(sword_name_room);


func _on_options_button_up() -> void:
	pass # Replace with function body.


func _on_quit_button_up() -> void:
	get_tree().quit();
