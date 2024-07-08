event_inherited();

player = instance_find(obj_player,0)
if scr_exists(player) and target == noone{
	target = instance_find(obj_module_cockpit,0)
	starting_distance = point_distance(phy_position_x,phy_position_y,target.phy_position_x,target.phy_position_y)
}
temp_speed = 4

// This part is just to move the crew to the cockpit and add to the ships crew

if owner == player{
	if scr_exists(joint)
		physics_joint_delete(joint)
	target = instance_find(obj_module_cockpit,0)
	temp_dir = point_direction(phy_position_x,phy_position_y,target.phy_position_x,target.phy_position_y)
	temp_distance = point_distance(phy_position_x,phy_position_y,target.phy_position_x,target.phy_position_y)
	scale = min(1,(4*temp_distance)/starting_distance)
	phy_position_x += lengthdir_x(temp_speed,temp_dir)
	phy_position_y += lengthdir_y(temp_speed,temp_dir)
	if (phy_position_x -target.phy_position_x) < 1 {
		temp_crew = instance_create_depth(0,0,-6,crew_object)
		temp_crew.owner = owner
		array_push(owner.crew, temp_crew)
	
		instance_destroy()
	}
	}