if owner == noone or !instance_exists(owner)
	instance_destroy()

rotation = -owner.phy_rotation
image_angle = rotation

if !instance_exists(module)
	module = noone

// Adjust module cost

if scr_exists(module){
	credit_cost = module.credit_cost
	diamond_cost = module.diamond_cost
}
else {
	credit_cost = 0
	diamond_cost = 0
}