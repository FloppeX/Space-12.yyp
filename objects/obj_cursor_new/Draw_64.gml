
module_under_cursor = instance_place(x,y,obj_module)


temp_x = 0.5 * display_get_gui_width() //obj_shop.x //module_under_cursor.x
temp_y = display_get_gui_height()-300//obj_shop.y + 120//module_under_cursor.y
tmp_box_width = 740*global.gui_scale
tmp_box_height = 320*global.gui_scale
tmp_offset_x = -0.5 * tmp_box_width 
tmp_offset_y = -0.5 * tmp_box_height
line_height = 42*global.gui_scale
line_spacing = 42*global.gui_scale

draw_sprite_ext(spr_shop_ui_4,-1,temp_x,temp_y+30,2.1*global.gui_scale,2.1*global.gui_scale,0,c_white,1)

draw_set_font(global.font_shop)
draw_set_valign(fa_top)

if module_under_cursor != noone and object_is_ancestor(module_under_cursor.object_index, obj_module_gun)
	{
		var number_of_modifiers = array_height_2d(module_under_cursor.modifiers)
		
		//tmp_box_width = 180
		//tmp_box_height = 8 + 20 * (number_of_modifiers +3)
		//tmp_offset_x = -0.5 * tmp_box_width //24
		//tmp_offset_y = -0.5 * tmp_box_height
		draw_set_color(c_navy)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,0)
		draw_set_color(c_white)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,1)
		//draw_line(temp_x+tmp_offset_x,temp_y+tmp_offset_y+line_height,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+line_height)
		
		draw_set_halign(fa_middle)
		draw_set_color(c_white)
		draw_text_ext_transformed(temp_x+tmp_offset_x+0.5*tmp_box_width,temp_y+tmp_offset_y+5,module_under_cursor.module_name,line_spacing,tmp_box_width,global.gui_scale,global.gui_scale,0)
		draw_set_halign(fa_left)
		draw_text_ext_transformed_color(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+line_height,"Weapon",line_spacing,tmp_box_width,1,1,0,c_fuchsia,c_fuchsia,c_fuchsia,c_fuchsia,1)
		if module_under_cursor.credit_cost > 0{
			draw_set_halign(fa_right)
			draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-22,temp_y+tmp_offset_y+5+line_height,string(module_under_cursor.credit_cost),line_spacing,tmp_box_width,1,1,0)
			draw_sprite_ext(spr_pickup_credit,-1,temp_x+tmp_offset_x+tmp_box_width-12,temp_y+tmp_offset_y+1.6*line_height,1.3,1.3,0,c_white,1)
		}
		else {
			draw_set_halign(fa_right)
			draw_text_ext_transformed_color(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Owned",line_spacing,tmp_box_width,1,1,0,c_lime,c_lime,c_lime,c_lime,1)
		}
		draw_set_halign(fa_left)
		draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+2*line_height,"DMG: " + string(floor(module_under_cursor.bullet_damage*10)/10),line_spacing,tmp_box_width,1,1,0)
		draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+3*line_height,"Range: " + string(round(module_under_cursor.bullet_range)),line_spacing,tmp_box_width,1,1,0)
		draw_set_halign(fa_right)
		draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5+2*line_height,"RoF: " + string(floor((60/module_under_cursor.bullet_interval*10))/10),line_spacing,tmp_box_width,1,1,0)
		draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5+3*line_height,"Recoil: " + string(floor(module_under_cursor.recoil_force*10)/10),line_spacing,tmp_box_width,1,1,0)
		draw_set_halign(fa_left)
		for(var i = 0; i < array_height_2d(module_under_cursor.modifiers); i+=1;)
			if module_under_cursor.modifiers[i,2] != noone{
				draw_set_color(c_lime)
				draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+4*line_height+line_height*i,module_under_cursor.modifiers[i,2],line_spacing,tmp_box_width,1,1,0)
				//draw_set_halign(fa_right)
				//draw_text_ext_transformed(temp_x+tmp_offset_x + tmp_box_width -5,temp_y+tmp_offset_y+25+20*i,module_under_cursor.modifiers[i,3],line_spacing,tmp_box_width,1,1,0)
				draw_set_halign(fa_left)
				}
		draw_set_color(c_white)
		draw_set_halign(fa_left)
		}
		
crew_under_cursor = instance_place(x,y,obj_module)

if crew_under_cursor != noone and object_is_ancestor(crew_under_cursor.object_index, obj_crew_token)
	{
		var number_of_modifiers = array_length(crew_under_cursor.description_lines)
		//var temp_x = crew_under_cursor.x
		//var temp_y = crew_under_cursor.y
		//tmp_box_width = 180
		//tmp_box_height = 8 + 18 * (number_of_modifiers +1)
		//tmp_offset_x = -0.5 * tmp_box_width //24
		//tmp_offset_y = -0.5 * tmp_box_height
		draw_set_color(c_navy)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,0)
		draw_set_color(c_white)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,1)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y+20,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+40,1)
		
		draw_set_halign(fa_middle)
		draw_set_color(c_white)
		draw_text_ext_transformed(temp_x+tmp_offset_x+0.5*tmp_box_width,temp_y+tmp_offset_y+5,crew_under_cursor.description_lines[0],line_spacing,tmp_box_width,1,1,0)
		draw_set_halign(fa_left)
		draw_text_ext_transformed_color(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+line_height,"Crew",line_spacing,tmp_box_width,1,1,0,c_fuchsia,c_fuchsia,c_fuchsia,c_fuchsia,1)
		
		if crew_under_cursor.diamond_cost > 0{
			draw_set_halign(fa_right)
			draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-22,temp_y+tmp_offset_y+5+line_height,string(crew_under_cursor.diamond_cost),line_spacing,tmp_box_width,1,1,0)
			draw_sprite_ext(spr_diamond,-1,temp_x+tmp_offset_x+tmp_box_width-12,temp_y+tmp_offset_y+1.6*line_height,1.3,1.3,0,c_white,1)
		}
		else {
			draw_set_halign(fa_right)
			draw_text_ext_transformed_color(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Owned",line_spacing,tmp_box_width,1,1,0,c_lime,c_lime,c_lime,c_lime,1)
		}
		draw_set_halign(fa_left)
		
		for(var i = 1; i < array_length(crew_under_cursor.description_lines); i+=1;)
			if crew_under_cursor.description_lines[i] != noone{
				draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+line_height+line_height*i,crew_under_cursor.description_lines[i],line_spacing,tmp_box_width,1,1,0)
				}
		
		
		}	
		
device_under_cursor = instance_place(x,y,obj_module)	
if device_under_cursor != noone and object_is_ancestor(device_under_cursor.object_index, obj_module_device)
	{
		var number_of_modifiers = array_length(device_under_cursor.description_lines)
		//var temp_x = device_under_cursor.x
		//var temp_y = device_under_cursor.y
		//tmp_box_width = 180
		//tmp_box_height = 8 + 18 * (number_of_modifiers +1)
		//tmp_offset_x = -0.5 * tmp_box_width //24
		//tmp_offset_y = -0.5 * tmp_box_height
		draw_set_color(c_navy)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,0)
		draw_set_color(c_white)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,1)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y+20,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+40,1)
		
		draw_set_halign(fa_middle)
		draw_set_color(c_white)
		
		draw_text_ext(temp_x+tmp_offset_x+0.5*tmp_box_width,temp_y+tmp_offset_y+5,device_under_cursor.description_lines[0],line_spacing,tmp_box_width)
		draw_set_halign(fa_left)
		draw_text_ext_transformed_color(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+line_height,"Device",line_spacing,tmp_box_width,1,1,0,c_fuchsia,c_fuchsia,c_fuchsia,c_fuchsia,1)
		
		if device_under_cursor.credit_cost > 0{
			draw_set_halign(fa_right)
			draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-22,temp_y+tmp_offset_y+5+line_height,string(device_under_cursor.credit_cost),line_spacing,tmp_box_width,1,1,0)
			draw_sprite_ext(spr_pickup_credit,-1,temp_x+tmp_offset_x+tmp_box_width-12,temp_y+tmp_offset_y+1.6*line_height,1.3,1.3,0,c_white,1)
		}
		else {
			draw_set_halign(fa_right)
			draw_text_ext_transformed_color(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Owned",line_spacing,tmp_box_width,1,1,0,c_lime,c_lime,c_lime,c_lime,1)
		}
		draw_set_halign(fa_left)
		
		for(var i = 1; i < array_length(device_under_cursor.description_lines); i+=1;)
			if device_under_cursor.description_lines[i] != noone{
				draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+line_height+line_height*i,device_under_cursor.description_lines[i],line_spacing,tmp_box_width,1,1,0)
				}
		
		
		}		

button_under_cursor = instance_place(x,y,obj_shop_button)
if button_under_cursor != noone
	{
		//var temp_x = button_under_cursor.x
		//var temp_y = button_under_cursor.y
		//tmp_box_width = 180
		//tmp_box_height = 8 + 18 * array_length_1d(button_under_cursor.description_lines)
		//tmp_offset_x = -0.5 * tmp_box_width //24
		//tmp_offset_y = -0.5 * tmp_box_height
		draw_set_color(c_black)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,0)
		draw_set_color(c_white)
		//draw_rectangle(temp_x+tmp_offset_x,temp_y+tmp_offset_y,temp_x+tmp_offset_x + tmp_box_width,temp_y+tmp_offset_y+tmp_box_height,1)
		
		draw_set_halign(fa_left)
		draw_set_color(c_white)
		
		for(var i = 0; i < array_length_1d(button_under_cursor.description_lines); i+=1;)
			draw_text_ext_transformed(temp_x+tmp_offset_x+5,temp_y+tmp_offset_y+5+20*i,button_under_cursor.description_lines[i],line_spacing,tmp_box_width,1,1,0)
		draw_set_halign(fa_right)
		if button_under_cursor.credit_cost > 0
			draw_text_ext_transformed(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Cost: " + string(button_under_cursor.credit_cost),line_spacing,tmp_box_width,1,1,0)
		else draw_text_ext_transformed_color(temp_x+tmp_offset_x+tmp_box_width-5,temp_y+tmp_offset_y+5,"Free",line_spacing,tmp_box_width,1,1,0,c_lime,c_lime,c_lime,c_lime,1)
		draw_set_halign(fa_left)
		}