function scr_explode_ship() {
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
		if scr_exists(ship_segment[i].module){
			debris = instance_create_depth(ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,5,obj_debris)
			debris.sprite_index = ship_segment[i].module.sprite_index
			debris.phy_speed_x = ship_segment[i].phy_speed_x
			debris.phy_speed_y = ship_segment[i].phy_speed_y
		}
		debris = instance_create_depth(ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,5,obj_debris)
		debris.sprite_index = spr_crossbar_2
		debris.phy_speed_x = ship_segment[i].phy_speed_x
		debris.phy_speed_y = ship_segment[i].phy_speed_y
		debris = instance_create_depth(ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,5,obj_debris)
		debris.sprite_index = spr_segment_2
		debris.phy_speed_x = ship_segment[i].phy_speed_x
		debris.phy_speed_y = ship_segment[i].phy_speed_y
	}
}