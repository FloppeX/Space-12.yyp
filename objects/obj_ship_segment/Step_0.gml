phy_rotation = owner.phy_rotation
alpha = owner.alpha

// Find mirror positions

scr_find_mirror_positions();

// Wrap movement

//scr_wrap_room();

// Update module placement

if scr_exists(module){
	module.module_segment = id
	module.owner = owner
	if ship_segment_above != noone
		module.module_above = ship_segment_above.module
	if ship_segment_right != noone
		module.module_right = ship_segment_right.module
	if ship_segment_below != noone
		module.module_below = ship_segment_below.module
	if ship_segment_left != noone
		module.module_left = ship_segment_left.module
}

// Adjust module cost

if scr_exists(module)
	module_cost = module.cost
else module_cost = 0