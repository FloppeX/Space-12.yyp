
open_timer -= 1
if scr_exists(module){
	module.owner = obj_shop
	door.open = false
	if door.fully_closed{
		obj_player.credits += module.credit_cost
		with(module)
			instance_destroy()
			open_timer = 120
	}
}
if !scr_exists(module) and open_timer <= 0{
	door.open = true
}