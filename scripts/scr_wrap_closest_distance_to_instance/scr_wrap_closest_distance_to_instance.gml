/// @function scr_wrap_closest_distance_to_instance(target_inst)
/// @param {Id.Instance} target_inst The specific instance to check distance to.
/// @description Calculates the shortest distance to a specific instance, considering screen wrap.
///              Assumes called from the searching instance (uses phy_position_x/y).
///              Requires global.play_area_width and global.play_area_height.
/// @returns {real} The shortest wrapped distance, or infinity if target doesn't exist.

function scr_wrap_closest_distance_to_instance(argument0) {
    var target_inst = argument0;

    if (!instance_exists(target_inst)) { return infinity; }

    var caller_x = phy_position_x;
    var caller_y = phy_position_y;

    // Calculate shortest wrapped vector components
    var dx = target_inst.phy_position_x - caller_x;
    var dy = target_inst.phy_position_y - caller_y;
    var half_width = global.play_area_width * 0.5;
    var half_height = global.play_area_height * 0.5;
    if (abs(dx) > half_width) { dx -= sign(dx) * global.play_area_width; }
    if (abs(dy) > half_height) { dy -= sign(dy) * global.play_area_height; }

    // Return the magnitude
    return point_distance(0, 0, dx, dy);
}
