for(var i = 0; i < array_length(shop_segments); i+=1;){
	if !scr_exists(shop_segments[i].module){
		shop_segments[i].module = scr_create_random_device();
		shop_segments[i].module.owner = obj_shop
		shop_segments[i].module.module_segment = shop_segments[i]
		shop_segments[i].module.owned_by_shop = true
		shop_segments[i].module.phy_position_x = shop_segments[i].phy_position_x
		shop_segments[i].module.phy_position_y = shop_segments[i].phy_position_y
		shop_segments[i].module.phy_rotation = ( phy_rotation - shop_segments[i].module.offset_angle)
		}
}