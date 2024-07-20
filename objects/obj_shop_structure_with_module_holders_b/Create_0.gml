event_inherited();

sprite_index = spr_shop_structure_a

shop_segments[1] = instance_create_depth(x-35,y-50,10,obj_shop_segment);
shop_segments[1].owner = obj_shop
shop_segments[1].visible = false
shop_segments[1].persistent = false
shop_segments[1].door = instance_create_depth(shop_segments[1].phy_position_x,shop_segments[1].phy_position_y,-20,obj_module_holder_door);

shop_segments[2] = instance_create_depth(x+35,y-50,10,obj_shop_segment);
shop_segments[2].owner = obj_shop
shop_segments[2].visible = false
shop_segments[2].persistent = false
shop_segments[2].door = instance_create_depth(shop_segments[2].phy_position_x,shop_segments[2].phy_position_y,-20,obj_module_holder_door);


shop_segments[3] = instance_create_depth(x-35,y+50,10,obj_shop_segment);
shop_segments[3].owner = obj_shop
shop_segments[3].visible = false
shop_segments[3].persistent = false
shop_segments[3].door = instance_create_depth(shop_segments[3].phy_position_x,shop_segments[3].phy_position_y,-20,obj_module_holder_door);

shop_segments[4] = instance_create_depth(x+35,y+50,10,obj_shop_segment);
shop_segments[4].owner = obj_shop
shop_segments[4].visible = false
shop_segments[4].persistent = false
shop_segments[4].door = instance_create_depth(shop_segments[4].phy_position_x,shop_segments[4].phy_position_y,-20,obj_module_holder_door);