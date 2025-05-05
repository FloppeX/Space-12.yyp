if !scr_exists(owner)
	exit;
	
depth = 10
	
phy_rotation = owner.phy_rotation
alpha = owner.alpha

// Find mirror positions

//scr_find_mirror_positions();

// Wrap movement

//scr_wrap_room();

// Update module placement

if scr_exists(module){
	module.ship_segment = id
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

if scr_exists(module){
	credit_cost = module.credit_cost
	diamond_cost = module.diamond_cost
}
else {
	credit_cost = 0
	diamond_cost = 0
}