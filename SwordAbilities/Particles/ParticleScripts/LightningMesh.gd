@tool
extends Node3D

@onready var top: Marker3D = %Top;
@onready var bottom: Marker3D = %Bottom;
@onready var lightning_node: Node3D = %LightningNode3D;
@onready var lightning_mesh: MeshInstance3D = %LightningMesh;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if( !top || !bottom || !lightning_node || !lightning_mesh):
		return;
	
	lightning_node.position= (top.position-bottom.position)/2+bottom.position;
	
	
	#rotate Y node to face markers
	var top_xz := Vector2(top.global_position.x,top.global_position.z); 
	var bottom_xz := Vector2(bottom.global_position.x,bottom.global_position.z);
	
	var opp: float = top_xz.y - bottom_xz.y;
	var adj: float = top_xz.x - bottom_xz.x;
	if (adj == 0): adj = 0.001;
	var tan_y: float = opp/adj;
	
	lightning_node.rotation.y = atan(-tan_y)+min(0,deg_to_rad(180)*sign(adj));
	
	
	#rotate Z node to face markers
	var opp2: float = top.global_position.y-bottom.global_position.y;
	var adj2: float = sqrt(pow(opp,2) + pow(adj,2));
	if(adj2 == 0): adj2 = 0.001;
	var tan_z: float = opp2/adj2;
	lightning_node.rotation.z = atan(tan_z);
	
	
	#scale Y to connect to markers
	lightning_mesh.scale.x = top.position.distance_to(bottom.position);
	
	
	if(get_viewport().get_camera_3d() == null):
		return;
	
	#rotate lightning_mesh Y to face camera
	var camera_pos : Vector3 = get_viewport().get_camera_3d().global_position;
	var vector_to_cam: Vector3 = camera_pos - lightning_node.global_position;
	
	var rot : Vector3 = lightning_node.global_rotation;
	#vector_to_cam = vector_to_cam.rotated(Vector3.RIGHT,-rot.x); #not needed. Always 0 anyways
	vector_to_cam = vector_to_cam.rotated(Vector3.UP,-rot.y);
	vector_to_cam = vector_to_cam.rotated(Vector3.BACK,-rot.z);
	
	if (vector_to_cam.z == 0): vector_to_cam.z = 0.001;
	var tan_x: float = vector_to_cam.y/vector_to_cam.z;
	lightning_mesh.rotation.x=atan(-tan_x)+min(0,deg_to_rad(180)*sign(vector_to_cam.z));

	
