/// @function scr_rocket_find_target_in_arc(target_type_or_name, angle, angle_arc, range)
/// @param target_type_or_name    The object index OR object name string to search for
/// @param angle                  The center angle of the search arc (degrees) (Direction the caller is looking)
/// @param angle_arc              The total width of the search arc (degrees)
/// @param range                  The maximum distance to search
/// @description Finds the closest visible instance of target_type within a specified arc and range,
///              considering screen wrap and Line of Sight (LOS). Returns instance ID or noone.
///              Assumes called from the searching instance (uses phy_position_x/y).
///              Requires global.play_area_width and global.play_area_height to be set.

function scr_rocket_find_target_in_arc(argument0, argument1, argument2, argument3) {

    // --- Argument Handling & Initialization ---
    var target_type; // This will hold the final object ID
    if (is_string(argument0)) {
        target_type = asset_get_index(argument0);
    } else {
        target_type = argument0;
    }

    var search_angle = argument1; // The center angle of the search cone
    var search_arc = argument2;   // The width of the search cone
    var search_range = argument3; // The maximum distance to check

    var caller_x = phy_position_x; // Assuming script is called from the searcher instance
    var caller_y = phy_position_y;

    var closest_target_inst = noone;
    var min_dist_sq = sqr(search_range); // Use squared distance for comparison efficiency

    // Safety Check for valid object type
    if (target_type < 0 || !object_exists(target_type)) {
        show_debug_message("scr_rocket_find_target_in_arc: ERROR - Invalid target_type resolved: " + string(target_type));
        return noone;
    }

    // Pre-calculate half wrap distances
    var half_width = global.play_area_width * 0.5;
    var half_height = global.play_area_height * 0.5;

    // --- Loop Through Target Instances ---
    var _instance_count = instance_number(target_type);
    for (var i = 0; i < _instance_count; i += 1) {
        var target_inst = instance_find(target_type, i);

        // Skip if instance is invalid or not visible
        if (!instance_exists(target_inst) || !target_inst.visible) {
            continue;
        }

        // --- Calculate Shortest Wrapped Vector & Distance ---
        var dx = target_inst.phy_position_x - caller_x;
        var dy = target_inst.phy_position_y - caller_y;

        // Adjust dx/dy for screen wrap to find the shortest vector path
        if (abs(dx) > half_width) {
            dx -= sign(dx) * global.play_area_width;
        }
        if (abs(dy) > half_height) {
            dy -= sign(dy) * global.play_area_height;
        }

        // Calculate squared distance using the wrapped vector components
        var current_dist_sq = sqr(dx) + sqr(dy);

        // --- Check if Closer and Within Range ---
        if (current_dist_sq < min_dist_sq) {

            // --- Check if Within Angle Arc ---
            // Calculate direction based on the shortest wrapped vector
            var current_direction = point_direction(0, 0, dx, dy);

            // Check if this direction is within the search arc
            if (abs(angle_difference(search_angle, current_direction)) < 0.5 * search_arc) {

                // --- Potential Target Found: Update Closest ---
                min_dist_sq = current_dist_sq;
                closest_target_inst = target_inst;
            }
        }
    } // --- End Instance Loop ---

    // --- Line of Sight (LOS) Check for the closest valid target ---
    if (instance_exists(closest_target_inst)) { // Use instance_exists for safety
        // Ensure the environment parent object exists before checking collision
        if (object_exists(obj_parent_environment)) {
            // Check LOS using the *actual* (non-wrapped) positions
            if (collision_line(caller_x, caller_y, closest_target_inst.phy_position_x, closest_target_inst.phy_position_y, obj_parent_environment, false, true)) {
                // show_debug_message("scr_rocket_find_target_in_arc: LOS to target " + string(closest_target_inst) + " blocked.");
                closest_target_inst = noone; // Target is blocked
            }
        } else {
             show_debug_message("scr_rocket_find_target_in_arc: WARNING - obj_parent_environment not found for LOS check.");
             // Decide if you should return noone or the target if the environment object doesn't exist
        }
    }

    // --- Return Result ---
    return closest_target_inst;
}
