/// @function scr_wrap_nearest_instance(obj_type)
/// @param {Asset.GMObject} obj_type   The object index to search for.
/// @description Finds the nearest instance of a given object type, considering screen wrap.
///              Assumes called from the searching instance (uses phy_position_x/y).
///              Requires global.play_area_width and global.play_area_height.
/// @returns {Id.Instance} The instance ID of the nearest instance, or noone.

function scr_wrap_nearest_instance(argument0) {
    var obj = argument0;
    var caller_x = phy_position_x;
    var caller_y = phy_position_y;

    var closest_instance = noone;
    var min_dist_sq = infinity; // Start with infinity

    // Safety check
    if (!object_exists(obj)) { return noone; }

    // Pre-calculate half wrap dimensions
    var half_width = global.play_area_width * 0.5;
    var half_height = global.play_area_height * 0.5;

    // Loop through instances
    var _instance_count = instance_number(obj);
    for (var i = 0; i < _instance_count; i += 1) {
        var target_inst = instance_find(obj, i);

        if (!instance_exists(target_inst)) continue; // Should not happen, but safe check

        // Calculate shortest wrapped vector components
        var dx = target_inst.phy_position_x - caller_x;
        var dy = target_inst.phy_position_y - caller_y;
        if (abs(dx) > half_width) { dx -= sign(dx) * global.play_area_width; }
        if (abs(dy) > half_height) { dy -= sign(dy) * global.play_area_height; }

        // Compare squared distance
        var current_dist_sq = sqr(dx) + sqr(dy);
        if (current_dist_sq < min_dist_sq) {
            min_dist_sq = current_dist_sq;
            closest_instance = target_inst;
        }
    }

    return closest_instance;
}
