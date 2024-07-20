event_inherited();
door_closed_timer_start = 240
door_closed_timer = door_closed_timer_start

depth = 0
sprite_index = spr_gunshop
color = c_white

shop_segments[0] = instance_create_depth(x+192,y+62,10,obj_shop_segment);
shop_segments[0].door = instance_create_depth(shop_segments[0].phy_position_x,shop_segments[0].phy_position_y,-20,obj_module_holder_door);


shop_segments[1] = instance_create_depth(x+71,y+161,10,obj_shop_segment);
shop_segments[1].door = instance_create_depth(shop_segments[1].phy_position_x,shop_segments[1].phy_position_y,-20,obj_module_holder_door);


shop_segments[2] = instance_create_depth(x+192,y+161,10,obj_shop_segment);
shop_segments[2].door = instance_create_depth(shop_segments[2].phy_position_x,shop_segments[2].phy_position_y,-20,obj_module_holder_door);


shop_segments[3] = instance_create_depth(x+73,y+258,10,obj_shop_segment);
shop_segments[3].door = instance_create_depth(shop_segments[3].phy_position_x,shop_segments[3].phy_position_y,-20,obj_module_holder_door);


shop_segments[4] = instance_create_depth(x+192,y+258,10,obj_shop_segment);
shop_segments[4].door = instance_create_depth(shop_segments[4].phy_position_x,shop_segments[4].phy_position_y,-20,obj_module_holder_door);


/*
for(var i = 0; i < array_length(shop_segments); i+=1;){
	shop_segments[i].module = scr_create_random_gun();
	shop_segments[i].module.owner = id
	shop_segments[i].module.module_segment = shop_segments[i]
	shop_segments[i].module.owned_by_shop = true
	shop_segments[i].module.phy_position_x = shop_segments[i].phy_position_x
	shop_segments[i].module.phy_position_y = shop_segments[i].phy_position_y
	shop_segments[i].module.phy_rotation = ( phy_rotation - shop_segments[i].module.offset_angle)
	}
