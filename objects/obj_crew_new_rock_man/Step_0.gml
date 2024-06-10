event_inherited();

// Increased health? Resistance to electricity?


if timer >= 4 and bonus_given == false{
	owner.obj_health += 15
	bonus_given = true
}

electric_field = instance_place(owner.phy_position_x,owner.phy_position_y,obj_effect_electrified)

if scr_exists(electric_field)
	with(electric_field)
		instance_destroy();