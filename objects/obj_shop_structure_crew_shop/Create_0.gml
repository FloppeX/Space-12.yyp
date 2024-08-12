event_inherited();
door_closed_timer_start = 240
door_closed_timer = door_closed_timer_start

depth = 0
sprite_index = spr_crew_shop
color = c_white

shop_segments[0] = instance_create_depth(x+59,y-50,10,obj_shop_segment);
shop_segments[0].joint = physics_joint_weld_create(shop_segments[0], id, shop_segments[0].phy_position_x,shop_segments[0].phy_position_y,0, 1, 1,false);
//shop_segments[0].door = instance_create_depth(shop_segments[0].phy_position_x,shop_segments[0].phy_position_y,-20,obj_module_holder_door);


shop_segments[1] = instance_create_depth(x-59,y+50,10,obj_shop_segment);
shop_segments[1].joint = physics_joint_weld_create(shop_segments[1], id, shop_segments[1].phy_position_x,shop_segments[1].phy_position_y,0, 1, 1,false);
//shop_segments[1].door = instance_create_depth(shop_segments[1].phy_position_x,shop_segments[1].phy_position_y,-20,obj_module_holder_door);


shop_segments[2] = instance_create_depth(x+59,y+50,10,obj_shop_segment);
shop_segments[2].joint = physics_joint_weld_create(shop_segments[2], id, shop_segments[2].phy_position_x,shop_segments[2].phy_position_y,0, 1, 1,false);
//shop_segments[2].door = instance_create_depth(shop_segments[2].phy_position_x,shop_segments[2].phy_position_y,-20,obj_module_holder_door);