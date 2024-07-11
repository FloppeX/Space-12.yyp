timer += 1

if timer >= 0.66*max_age{
	if scr_timer(8) 
		if alpha == 1
			alpha = 0.5
		else alpha = 1
	}
	
if timer >= 5/6*max_age{
	if scr_timer(4) 
		if alpha == 1
			alpha = 0.5
		else alpha = 1
	}
		
if timer >= max_age{
	scale -= 0.01
	alpha = 1
}

if scale <= 0
	instance_destroy()
		
// Apply max speed

if phy_speed > max_speed
	phy_linear_damping = 6
else 
	phy_linear_damping = 2
	
//

scr_find_mirror_positions();

scr_wrap_room();
