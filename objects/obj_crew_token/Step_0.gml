event_inherited();

temp_obj = instance_find(obj_player,0)

if owner == temp_obj{
	temp_crew = instance_create_depth(0,0,-6,crew_object)
	temp_crew.owner = owner
	array_push(owner.crew, temp_crew)
	physics_joint_delete(joint)
	instance_destroy()
	}