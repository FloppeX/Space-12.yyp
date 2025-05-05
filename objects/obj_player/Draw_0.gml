
/*
for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
	//if ship_segment[i].ship_segment_right != noone
		draw_sprite_ext(spr_segment_2,-1,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,1,1,-phy_rotation,c_white,alpha)
*/
// TEST
if global.view_mode == 2{
	draw_set_font(global.font_small_text)
	draw_set_halign(fa_center)
	draw_set_color(c_white)
	number_of_map_objects = 0
	while(map_objects[number_of_map_objects,0] != noone)
		number_of_map_objects += 1
	draw_text(phy_position_x,phy_position_y+80,"phy_pos_x: " + string(phy_position_x))
	draw_text(phy_position_x,phy_position_y+100,"phy_pos_y: " + string(phy_position_y))
	}
	// --- Draw Physics Center of Mass Marker (Using phy_com_x/y) ---
var marker_size = 8; // Size of the cross marker arms
var marker_color = c_lime; // Bright color for visibility



// --- DEBUG: Check phy_com and phy_position values ---
var _com_x_rel = phy_com_x;
var _com_y_rel = phy_com_y;
var _pos_x = phy_position_x;
var _pos_y = phy_position_y;

/* 
// Add a message that prints every few steps
if (timer mod 30 == 0) { // Print roughly twice per second at 60fps
     show_debug_message("Player Draw: Pos=(" + string(_pos_x) + "," + string(_pos_y) + ") Rel CoM=(" + string(_com_x_rel) + "," + string(_com_y_rel) + ")");
}
// --- END DEBUG ---

*/

// --- TEMPORARILY REMOVED SCREEN WRAP LOOP FOR DEBUGGING ---
// Calculate the single draw position
var _draw_com_x = _pos_x + _com_x_rel;
var _draw_com_y = _pos_y + _com_y_rel;

// Check if coordinates are valid numbers before drawing
if (!is_nan(_draw_com_x) && !is_nan(_draw_com_y)) {
    // Force draw settings right before drawing
    draw_set_color(marker_color);
    draw_set_alpha(1);

    // Draw a simple cross marker at the physics CoM
    draw_line(_draw_com_x - marker_size, _draw_com_y, _draw_com_x + marker_size, _draw_com_y); // Horizontal line
    draw_line(_draw_com_x, _draw_com_y - marker_size, _draw_com_x, _draw_com_y + marker_size); // Vertical line

    // Reset draw settings if needed immediately after
    // draw_set_color(c_white);
    // draw_set_alpha(1);
} else {
     if (timer mod 30 == 0) { show_debug_message(" WARN: CoM draw coordinates are NaN!"); }
}
// --- END TEMPORARY SINGLE DRAW ---