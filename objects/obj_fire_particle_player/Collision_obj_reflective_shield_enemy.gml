//

if joint == noone
	joint = physics_joint_weld_create(id, other,phy_position_x,phy_position_y,0, 10, 1, 1);
	
if scr_timer(10)
	other.obj_health -= damage;