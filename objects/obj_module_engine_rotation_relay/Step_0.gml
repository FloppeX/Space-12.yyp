event_inherited();

with(obj_module_engine)
	if scr_module_is_neighbor(other,id){
		target_angle = -owner.phy_rotation + offset_angle + owner.rotation_value*20
		other.will_affect_neighbor = true
	}
