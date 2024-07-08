with(obj_enemy_ship)
	if target = other.owner
		other.targeted = true
		
if targeted and cloak_timer > 0{
	owner.invisible = true
	owner.alpha = 0.2
	cloak_timer -= 1
	interval_timer = interval_timer_start
}
else{
	owner.invisible = false
	owner.alpha = 1
	interval_timer -= 1
	if interval_timer <= 0
		cloak_timer = cloak_timer_start
}