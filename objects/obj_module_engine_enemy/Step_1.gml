event_inherited();

if scr_exists(owner)
	owner.max_speed_bonus += 0.4
else
	instance_destroy()
