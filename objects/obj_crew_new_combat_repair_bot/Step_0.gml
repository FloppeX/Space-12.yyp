event_inherited();

if scr_timer(20){
	if owner.obj_health < (owner.max_health/3){
		owner.obj_health += 0.5
	}
}

