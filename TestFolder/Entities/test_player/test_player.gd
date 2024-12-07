extends Creature3D



@export_group("Camera")
@export var spring_arm: SpringArm3D;
@export var cam_pitch_clamp: Vector2 = Vector2(-90,30);
@export var default_spring_length: float = 6.0;
@export var camera_offset: Vector3 = Vector3(0,0.5,0);

@export_group("Animation")
@export var animation_player: AnimationPlayer;


signal attack_start();
signal attack_end();

func _init() -> void:
	attack_start.connect(attacking);



func _ready() -> void:
	default_material = body.mesh.surface_get_material(0).duplicate(true);
	#setting health bars and default stats
	set_stats();


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity;

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down");
	var direction := (spring_arm.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized();
	if direction:
		velocity.x = direction.x * speed;
		velocity.z = direction.z * speed;
	else:
		velocity.x = move_toward(velocity.x, 0, speed);
		velocity.z = move_toward(velocity.z, 0, speed);

	if (input_dir && is_on_floor()):
		rotation.y= spring_arm.rotation.y;

	move_and_slide();
	
	#update camera
	spring_arm.position=position+camera_offset;
	

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion):
		spring_arm.rotation += Vector3(-event.relative.y,-event.relative.x,0)*0.01;
		spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(cam_pitch_clamp.x),deg_to_rad(cam_pitch_clamp.y));
	
	spring_arm.spring_length+= (float(Input.is_action_just_released("mouseWheelDown"))-float(Input.is_action_just_released("mouseWheelUp")))
	spring_arm.spring_length = clamp(spring_arm.spring_length,1.0,20.0);
	if (Input.is_action_just_pressed("mouseWheelPressed")):
		spring_arm.spring_length = default_spring_length;
	
	if(Input.is_action_just_pressed("attack") && animation_player.current_animation != "Attack"):
		attack_start.emit();
		


func attacking()-> void:
	rotation.y= spring_arm.rotation.y;
	animation_player.play("Attack");

	
func transition_to_idle()->void:
	#called in the AnimationPlayer at the end of an attack
	attack_end.emit();
	animation_player.play("Idle");
	
