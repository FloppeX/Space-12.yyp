//

draw_self();

// Show where module can be placed


if scr_exists(cursor_module){
	with(obj_player)
		for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
			if scr_check_module_placement(other.cursor_module,ship_segment[i])
				draw_sprite(spr_module_holder_green,-1,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y)
			else 
				draw_sprite(spr_module_holder_red,-1,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y)
		}
	}
	


// UI

draw_set_font(global.font_small_text)
draw_set_color(c_white)

module_under_cursor = instance_place(x,y,obj_module)

		
if selected_module != noone{
	draw_circle_color(selected_module.phy_position_x,selected_module.phy_position_y,40,c_red,c_red,1)
	}
if global.view_mode == 2{
	draw_set_font(global.font_menu)
	draw_set_color(c_white)
	draw_text(x,y+80,"cursor_module: " + string(cursor_module))
	draw_text(x,y+110,"cursor_module_swap: " + string(cursor_module_swap))
	draw_text(x,y+140,"segment_module: " + string(segment_module))
	draw_text(x,y+170,"segment_module_swap: " + string(segment_module_swap))
}