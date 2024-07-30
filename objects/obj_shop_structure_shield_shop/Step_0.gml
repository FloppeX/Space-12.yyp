event_inherited()

for(var i = 0; i < array_length(shop_segments); i+=1;){
	if !scr_exists(shop_segments[i].module){
		shop_segments[i].door.close = true
		shop_segments[i].door.open = false
		if shop_segments[i].door.fully_closed == true{
			shop_segments[i].module = scr_create_random_device()
			shop_segments[i].module.owner = obj_shop
			shop_segments[i].module.module_segment = shop_segments[i]
			shop_segments[i].module.owned_by_shop = true
			shop_segments[i].module.phy_position_x = shop_segments[i].phy_position_x
			shop_segments[i].module.phy_position_y = shop_segments[i].phy_position_y
			shop_segments[i].module.phy_rotation = -90 -shop_segments[i].module.offset_angle
			door_closed_timer = door_closed_timer_start
		}
	}
	if scr_exists(shop_segments[i].module){
		door_closed_timer -= 1
		if door_closed_timer <= 0{
			shop_segments[i].door.close = false
			shop_segments[i].door.open = true
			}
		scr_adjust_module_placement_shop(shop_segments[i].module,shop_segments[i])
	}
}