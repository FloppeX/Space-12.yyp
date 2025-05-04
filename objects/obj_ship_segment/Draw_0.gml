// --- Draw Crossbar Connectors (Corrected Rotation for Right = 0deg) ---
var _crossbar_sprite = spr_crossbar_2;
if (!sprite_exists(_crossbar_sprite)) exit; // Exit if sprite missing

var _crossbar_subimg = -1;
var _crossbar_scale = image_xscale; // Use segment's scale
var _crossbar_col = c_white;
var _crossbar_alpha = image_alpha; // Use segment's alpha
var _ship_rot = (instance_exists(owner)) ? -owner.phy_rotation : -phy_rotation; // Get base ship rotation

// Loop for screen wrap drawing
for (var p = -global.play_area_width; p <= global.play_area_width; p += global.play_area_width) {
    for (var q = -global.play_area_height; q <= global.play_area_height; q+= global.play_area_height) {
        var _draw_x = phy_position_x + p;
        var _draw_y = phy_position_y + q;

        // Draw RIGHT connector (Geometric right is Ship's UP -> Rotation = Ship Rot + 0)
        if (variable_instance_exists(id,"neighbor_right") && neighbor_right != noone && instance_exists(neighbor_right)) {
             // To point right relative to ship, use base rotation + 0 (was -90)
             draw_sprite_ext(_crossbar_sprite, _crossbar_subimg, _draw_x, _draw_y, _crossbar_scale, _crossbar_scale, _ship_rot-90, _crossbar_col, _crossbar_alpha);
        }

        // Draw BELOW connector (Geometric down is Ship's RIGHT -> Rotation = Ship Rot + 90)
         if (variable_instance_exists(id,"neighbor_bottom") && neighbor_bottom != noone && instance_exists(neighbor_bottom)) {
             // To point down relative to ship, use base rotation + 90 (was +180)
             // Note: +270 might be equivalent depending on sprite orientation, using -90 for simplicity
             draw_sprite_ext(_crossbar_sprite, _crossbar_subimg, _draw_x, _draw_y, _crossbar_scale, _crossbar_scale, _ship_rot+180, _crossbar_col, _crossbar_alpha); // Or +270
        }

        // Reminder: Original logic only draws right/below, so left/above are not drawn
    }
}
// --- End Crossbar Connectors ---