event_inherited();

depth = 0
sprite_index = spr_device_shop
color = c_white

shop_segments[0] = instance_create_depth(x+48,y+58,10,obj_shop_segment);
shop_segments[0].door = instance_create_depth(shop_segments[0].phy_position_x,shop_segments[0].phy_position_y,-20,obj_module_holder_door);


shop_segments[1] = instance_create_depth(x+48,y+156,10,obj_shop_segment);
shop_segments[1].door = instance_create_depth(shop_segments[1].phy_position_x,shop_segments[1].phy_position_y,-20,obj_module_holder_door);


shop_segments[2] = instance_create_depth(x+166,y+156,10,obj_shop_segment);
shop_segments[2].door = instance_create_depth(shop_segments[2].phy_position_x,shop_segments[2].phy_position_y,-20,obj_module_holder_door);


shop_segments[3] = instance_create_depth(x+48,y+252,10,obj_shop_segment);
shop_segments[3].door = instance_create_depth(shop_segments[3].phy_position_x,shop_segments[3].phy_position_y,-20,obj_module_holder_door);


shop_segments[4] = instance_create_depth(x+166,y+252,10,obj_shop_segment);
shop_segments[4].door = instance_create_depth(shop_segments[4].phy_position_x,shop_segments[4].phy_position_y,-20,obj_module_holder_door);


/*
for(var i = 0; i < array_length(shop_segments); i+=1;){
	shop_segments[i].module = scr_create_rando segments[i]
	shop_segments[i].module.owned_by_shop = true
	shop_segments[i].module.phy_position_x = shop_segments[i].phy_position_x
	shop_segments[i].module.phy_position_y = shop_segments[i].phy_position_y
	shop_segments[i].module.phy_rotation = ( phy_rotation - shop_segments[i].module.offset_angle)
	}
