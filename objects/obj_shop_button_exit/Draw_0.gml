event_inherited();


if show_module_placement{
	with(obj_player)
			for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
				if scr_check_module_placement(ship_segment[i].module,ship_segment[i])
					draw_sprite(spr_module_holder_green,-1,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y)
				else 
					draw_sprite(spr_module_holder_red,-1,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y)
			}
		
	module_placement_timer -= 1
	if module_placement_timer <= 0{
		module_placement_timer = 300
		show_module_placement = false
	}
}