extends XFactor


static func on_hit(user: Creature3D,target: Creature3D,duration: float =0.0,status_name: String = "") -> void:
	OS.shell_open("https://www.youtube.com/watch?v=6n3pFFPSlW4&autoplay=1");
	target.get_tree().quit();
