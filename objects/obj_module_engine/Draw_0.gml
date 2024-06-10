/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if global.view_mode == 2{
	draw_set_font(global.font_small_text)
	draw_set_color(c_white)
	draw_text(x,y+180,energy_cost)
}