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

if module_under_cursor != noone and object_is_ancestor(module_under_cursor.object_index, obj_module_gun)
	{
		var number_of_modifiers = array_height_2d(module_under_cursor.modifiers)
		var temp_x = module_under_cursor.x
		var temp_y = module_under_cursor.y
		var tmp_box_width = 180
		var tmp_box_height = 8 + 20 * (number_of_modifiers +3)
		var tmp_offset_x = 24
		var tmp_offset_y = -0.5 * tmp_box_height
		draw_set_color(c_navy)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,0)
		draw_set_color(c_white)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,1)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y+20,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+40,1)
		draw_set_font(global.font_big_text)
		draw_set_valign(fa_middle)
		draw_set_halign(fa_middle)
		draw_set_color(c_white)
		draw_text_ext_transformed(temp_x+tmp_offset_x+0.5*tmp_box_width,temp_y+tmp_offset_y+5,module_under_cursor.module_name,0,800,0.3,0.3,0)
		draw_set_halign(fa_left)
		draw_text_ext_transformed_color(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+25,"Weapon",0,800,0.3,0.3,0,c_fuchsia,c_fuchsia,c_fuchsia,c_fuchsia,1)
		if module_under_cursor.cost > 0{
			draw_set_halign(fa_right)
			draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-20,temp_y+tmp_offset_y+25,string(module_under_cursor.cost),0,800,0.3,0.3,0)
			draw_sprite_ext(spr_pickup_credit,-1,temp_x+tmp_offset_x+tmp_box_width-12,temp_y+tmp_offset_y+29,1,1,0,c_white,1)
		}
		else draw_text_ext_transformed_color(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Owned",0,800,0.3,0.3,0,c_lime,c_lime,c_lime,c_lime,1)
		draw_set_halign(fa_left)
		draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+45,"DMG: " + string(floor(module_under_cursor.bullet_damage*10)/10),0,800,0.3,0.3,0)
		draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+65,"Range: " + string(round(module_under_cursor.bullet_range)),0,800,0.3,0.3,0)
		draw_set_halign(fa_right)
		draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+45,"RoF: " + string(floor((60/module_under_cursor.bullet_interval*10))/10),0,800,0.3,0.3,0)
		draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+65,"Recoil: " + string(floor(module_under_cursor.recoil_force*10)/10),0,800,0.3,0.3,0)
		draw_set_halign(fa_left)
		for(var i = 0; i < array_height_2d(module_under_cursor.modifiers); i+=1;)
			if module_under_cursor.modifiers[i,2] != noone{
				draw_set_color(c_lime)
				draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+85+20*i,module_under_cursor.modifiers[i,2],0,800,0.3,0.3,0)
				//draw_set_halign(fa_right)
				//draw_text_ext_transformed(temp_x+tmp_offset_x + tmp_box_width -5,temp_y+tmp_offset_y+25+20*i,module_under_cursor.modifiers[i,3],0,800,0.3,0.3,0)
				draw_set_halign(fa_left)
				}
		draw_set_color(c_white)
		draw_set_halign(fa_left)
		}
		
crew_under_cursor = instance_place(x,y,obj_module)

if crew_under_cursor != noone and object_is_ancestor(crew_under_cursor.object_index, obj_crew_token)
	{
		var number_of_modifiers = array_length(crew_under_cursor.description_lines)
		var temp_x = crew_under_cursor.x
		var temp_y = crew_under_cursor.y
		var tmp_box_width = 180
		var tmp_box_height = 8 + 18 * (number_of_modifiers +1)
		var tmp_offset_x = 24
		var tmp_offset_y = -0.5 * tmp_box_height
		draw_set_color(c_navy)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,0)
		draw_set_color(c_white)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,1)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y+20,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+40,1)
		draw_set_font(global.font_big_text)
		draw_set_valign(fa_middle)
		draw_set_halign(fa_middle)
		draw_set_color(c_white)
		draw_text_ext_transformed(temp_x+tmp_offset_x+0.5*tmp_box_width,temp_y+tmp_offset_y+5,crew_under_cursor.description_lines[0],0,800,0.3,0.3,0)
		draw_set_halign(fa_left)
		draw_text_ext_transformed_color(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+25,"Crew",0,800,0.3,0.3,0,c_fuchsia,c_fuchsia,c_fuchsia,c_fuchsia,1)
		
		if crew_under_cursor.cost > 0{
			draw_set_halign(fa_right)
			draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-20,temp_y+tmp_offset_y+25,string(crew_under_cursor.cost),0,800,0.3,0.3,0)
			draw_sprite_ext(spr_pickup_credit,-1,temp_x+tmp_offset_x+tmp_box_width-12,temp_y+tmp_offset_y+29,1,1,0,c_white,1)
		}
		else draw_text_ext_transformed_color(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Owned",0,800,0.3,0.3,0,c_lime,c_lime,c_lime,c_lime,1)
		draw_set_font(global.font_big_text)
		draw_set_halign(fa_left)
		for(var i = 1; i < array_length(crew_under_cursor.description_lines); i+=1;)
			if crew_under_cursor.description_lines[i] != noone{
				draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+25+20*i,crew_under_cursor.description_lines[i],0,800,0.3,0.3,0)
				draw_set_halign(fa_left)
				}
		
		
		}	
		
device_under_cursor = instance_place(x,y,obj_module)	
if device_under_cursor != noone and object_is_ancestor(device_under_cursor.object_index, obj_module_device)
	{
		var number_of_modifiers = array_length(device_under_cursor.description_lines)
		var temp_x = device_under_cursor.x
		var temp_y = device_under_cursor.y
		var tmp_box_width = 180
		var tmp_box_height = 8 + 18 * (number_of_modifiers +1)
		var tmp_offset_x = 24
		var tmp_offset_y = -0.5 * tmp_box_height
		draw_set_color(c_navy)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,0)
		draw_set_color(c_white)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,1)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y+20,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+40,1)
		draw_set_font(global.font_big_text)
		draw_set_valign(fa_middle)
		draw_set_halign(fa_middle)
		draw_set_color(c_white)
		draw_text_ext_transformed(temp_x+tmp_offset_x+0.5*tmp_box_width,temp_y+tmp_offset_y+5,device_under_cursor.description_lines[0],0,800,0.3,0.3,0)
		draw_set_halign(fa_left)
		draw_text_ext_transformed_color(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+25,"Device",0,800,0.3,0.3,0,c_fuchsia,c_fuchsia,c_fuchsia,c_fuchsia,1)
		
		if device_under_cursor.cost > 0{
			draw_set_halign(fa_right)
			draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-20,temp_y+tmp_offset_y+25,string(device_under_cursor.cost),0,800,0.3,0.3,0)
			draw_sprite_ext(spr_pickup_credit,-1,temp_x+tmp_offset_x+tmp_box_width-12,temp_y+tmp_offset_y+29,1,1,0,c_white,1)
		}
		else draw_text_ext_transformed_color(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Owned",0,800,0.3,0.3,0,c_lime,c_lime,c_lime,c_lime,1)
		draw_set_font(global.font_big_text)
		draw_set_halign(fa_left)
		for(var i = 1; i < array_length(device_under_cursor.description_lines); i+=1;)
			if device_under_cursor.description_lines[i] != noone{
				draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+25+20*i,device_under_cursor.description_lines[i],0,800,0.3,0.3,0)
				draw_set_halign(fa_left)
				}
		
		
		}		

button_under_cursor = instance_place(x,y,obj_shop_button)
if button_under_cursor != noone
	{
		var temp_x = button_under_cursor.x
		var temp_y = button_under_cursor.y
		var tmp_box_width = 180
		var tmp_box_height = 8 + 18 * array_length_1d(button_under_cursor.description_lines)
		var tmp_offset_x = 24
		var tmp_offset_y = -0.5 * tmp_box_height
		draw_set_color(c_black)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,0)
		draw_set_color(c_white)
		draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,1)
		draw_set_font(global.font_big_text)
		draw_set_valign(fa_middle)
		draw_set_halign(fa_left)
		draw_set_color(c_white)
		for(var i = 0; i < array_length_1d(button_under_cursor.description_lines); i+=1;)
			draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+20*i,button_under_cursor.description_lines[i],0,800,0.3,0.3,0)
		draw_set_halign(fa_right)
		if button_under_cursor.cost > 0
			draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Cost: " + string(button_under_cursor.cost),0,800,0.3,0.3,0)
		else draw_text_ext_transformed_color(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Free",0,800,0.3,0.3,0,c_lime,c_lime,c_lime,c_lime,1)
		draw_set_halign(fa_left)
		}
		
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