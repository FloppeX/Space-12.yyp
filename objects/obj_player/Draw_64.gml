// TEST
/*
if global.view_mode == 2{
	draw_set_font(global.font_big_text)
	draw_set_color(c_white)
	draw_text(50,90,"zoom: " + string(global.zoom))
	draw_text(50,120,"difficulty: " + string(global.difficulty_level))
	draw_text(50,150,"max speed: " + string(max_speed))
	draw_text(50,180,"rotation_speed: " + string(rotation_speed))
	draw_text(50,210,"max_health: " + string(max_health))
	draw_text(50,240,"max_energy: " + string(max_energy))
	draw_text(50,270,"energy_increase: " + string(energy_increase))
	draw_text(50,300,"enemies killed: " + string(enemies_killed))
	draw_text(50,330,"bullets fired: " + string(bullets_fired))
	draw_text(50,360,"credits gained: " + string(credits_gained))
	draw_text(50,390,"crew array length: " + string(array_length(global.array_player_crew)))
	
	draw_sprite_ext(spr_scatter_gun_new_white,-1, 250,630,12,12,0,c_lime,1)
}
*/

// MAP

if show_map{
	draw_sprite_ext(spr_radar,-1, map_edge_left+ 0.5*map_width,map_edge_top+0.5*map_height,global.gui_scale * map_scale * 0.9,global.gui_scale * map_scale * 0.9,0,c_white,1)
	scr_draw_objects_on_map()
	draw_sprite_ext(spr_map_marker_player,-1, map_center_x,map_center_y,global.gui_scale * map_scale,global.gui_scale * map_scale,-phy_rotation,c_white,1)
	}
// Health bar + energy_bar + particle bar

draw_healthbar(health_bar_x-0.5 * health_bar_width,health_bar_y+0.5 * health_bar_height - health_bar_height * max_health/max_health_base ,health_bar_x+0.5 * health_bar_width,health_bar_y+0.5 * health_bar_height,100 * obj_health/max_health,c_dkgray,c_maroon,c_maroon,3,true,true)

draw_healthbar(energy_bar_x-0.5 * health_bar_width,energy_bar_y+0.5 * energy_bar_height - energy_bar_height * max_energy/max_energy_base,energy_bar_x+0.5 * health_bar_width,energy_bar_y+0.5 * health_bar_height,100 * energy/max_energy,c_dkgray,c_lime,c_lime,3,true,true)

draw_healthbar(particles_bar_x-0.5 * health_bar_width,particles_bar_y+0.5 * particles_bar_height - particles_bar_height * max_particles/max_particles_base,particles_bar_x+0.5 * health_bar_width,particles_bar_y+0.5 * particles_bar_height,100 * particles/max_particles,c_dkgray,c_aqua,c_aqua,3,true,true)

// Credits

draw_sprite_ext(spr_pickup_credit,-1,global.gui_unit * 0.2,health_bar_y + 0.5 * health_bar_height +  global.gui_unit * 0.25,4 * global.gui_scale,4 * global.gui_scale,0,c_white,1)
draw_set_font(font_damage_number)
draw_set_color(c_white)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)
draw_text_transformed(global.gui_unit * 0.6,health_bar_y + 0.5 * health_bar_height + global.gui_unit * 0.25,credits,global.gui_scale,global.gui_scale,0)

// Diamonds

draw_sprite_ext(spr_diamond,-1,global.gui_unit * 0.2,health_bar_y + 0.5 * health_bar_height +  global.gui_unit * 0.65,4 * global.gui_scale,4 * global.gui_scale,0,c_white,1)
draw_set_font(font_damage_number)
draw_set_color(c_white)
draw_set_valign(fa_middle)
draw_set_halign(fa_center)
draw_text_transformed(global.gui_unit * 0.6,health_bar_y + 0.5 * health_bar_height +  global.gui_unit * 0.65,diamonds,global.gui_scale,global.gui_scale,0)


// Active item

if scr_exists(selected_active_module){//and scr_exists(modules[selected_active_module,0]){
	draw_sprite_ext(spr_module_holder,-1,global.gui_unit * 0.2,health_bar_y + 0.5 * health_bar_height + 180,5,5,0,c_white,1)
	draw_sprite_ext(selected_active_module.sprite_index,-1,energy_bar_x,health_bar_y + 0.5 * health_bar_height + 180,5,5,selected_active_module.offset_angle+90,c_white,1)
	}
	
/*
// Crew
draw_set_font(global.font_big_text)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
for(var i = 0; i < array_height_2d(modifiers); i+=1;)
			if modifiers[i,0] != noone{
				draw_sprite_ext(modifiers[i,4],-1,health_bar_x + global.gui_unit * 0.16,health_bar_y + 0.5 * health_bar_height + 2 * global.gui_unit +global.gui_unit * 0.5*i,global.gui_scale * 4,global.gui_scale * 4,0,c_white,1)
				draw_text_ext_transformed(health_bar_x + 80,health_bar_y + 0.5 * health_bar_height + global.gui_unit * 2+global.gui_unit * 0.5*i,modifiers[i,2],0,800,global.gui_scale,global.gui_scale,0)
				}
*/				
// Crew new
draw_set_halign(fa_middle)
draw_set_valign(fa_middle)
for(var i = 0; i < array_length(crew); i+=1;){
	if crew[i] != noone 
		draw_sprite_ext(crew[i].sprite_index,-1,display_get_gui_width() - 0.5 * global.gui_unit,0.5 * display_get_gui_height() - 0.5 * (0.6 * global.gui_unit * (array_length(crew) -1) )+ 0.6 * global.gui_unit*i,global.gui_scale * 5,global.gui_scale * 5,0,c_white,1)
}
