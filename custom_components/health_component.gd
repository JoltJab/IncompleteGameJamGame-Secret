class_name HealthComponent extends Node

@export var max_health: float = 100;
@export var health: float = 100;

signal health_changed(new_health:float,old_health:float);
signal max_health_changed(new_max_health:float,old_max_health:float);
signal took_damage(damage:float);
signal healed(health:float);

func change_health(change: float=0)-> void:
	
	var old_health = health;
	health = clamp(health+change,0,max_health);
	
	if(old_health>health): #took damage
		took_damage.emit(change);
	elif(old_health<health): #healed
		healed.emit(change)
	
	health_changed.emit(health,old_health);
	

func change_max_health(change: float=0)-> void:
	#additive and not replacing
	var old_max_health = max_health;
	max_health += change;
	
	max_health_changed.emit(max_health,old_max_health);
