event_inherited();
door_closed_timer_start = 240
door_closed_timer = door_closed_timer_start

depth = 0
sprite_index = spr_gun_shop_2
color = c_white
shop_segments[0] = instance_create_depth(x-59,y-50,10,obj_shop_segment);
shop_segments[0].joint = physics_joint_weld_create(shop_segments[0], id, shop_segments[0].phy_position_x,shop_segments[0].phy_position_y,0, 1, 1,false);

shop_segments[1] = instance_create_depth(x-59,y+50,10,obj_shop_segment);
shop_segments[1].joint = physics_joint_weld_create(shop_segments[1], id, shop_segments[1].phy_position_x,shop_segments[1].phy_position_y,0, 1, 1,false);

shop_segments[2] = instance_create_depth(x+59,y+50,10,obj_shop_segment);
shop_segments[2].joint = physics_joint_weld_create(shop_segments[2], id, shop_segments[2].phy_position_x,shop_segments[2].phy_position_y,0, 1, 1,false);

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
