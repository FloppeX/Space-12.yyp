timer += 1

if timer >= max_age
	instance_destroy();
	
if timer >= 0.66*max_age{
	if scr_timer(8) 
		if visible == true
			visible = false
		else visible = true
	}
	
if timer >= 5/6*max_age{
	if scr_timer(4) 
		if visible == true
			visible = false
		else visible = true
	}
		
		
// Apply max speed

if phy_speed > max_speed
	phy_linear_damping = 6
else 
	phy_linear_damping = 2
	
//

scr_find_mirror_positions();

scr_wrap_room();
