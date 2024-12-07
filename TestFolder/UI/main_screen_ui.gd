extends Control

@export_group("Health Bars")
@export var my_health_bar: ProgressBar;
@export var boss_health_bar: ProgressBar;




func my_health_changed(new_health: float) -> void:
	my_health_bar.value = new_health;

func boss_health_changed(new_health: float) -> void:
	await get_tree().physics_frame;
	boss_health_bar.value = new_health;
	
	
func my_max_health_changed(new_health: float) -> void:
	my_health_bar.max_value = new_health;
	
func boss_max_health_changed(new_health: float) -> void:
	boss_health_bar.max_value = new_health;
