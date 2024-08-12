var temp_timer = min(4*timer,100)

draw_line_width_color(0.31 * display_get_gui_width()+2,0.1 * display_get_gui_height()+2,0.31 * display_get_gui_width() + temp_timer/100 * 0.38 * display_get_gui_width()+2,0.1 * display_get_gui_height()+2,10,c_purple,c_purple)
draw_line_width_color(0.31 * display_get_gui_width(),0.1 * display_get_gui_height(),0.31 * display_get_gui_width() + temp_timer/100 * 0.38 * display_get_gui_width(),0.1 * display_get_gui_height(),10,c_fuchsia,c_fuchsia)

draw_sprite_ext(sprite_index,-1,draw_position_x,draw_position_y,3*global.gui_scale * temp_scale,3*global.gui_scale * temp_scale,rotation,c_white,1)