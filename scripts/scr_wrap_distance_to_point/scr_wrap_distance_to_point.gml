/// @function scr_wrap_distance_to_point(origin_x, origin_y, target_x, target_y)
/// @param {real} origin_x      The starting X coordinate.
/// @param {real} origin_y      The starting Y coordinate.
/// @param {real} target_x      The target X coordinate.
/// @param {real} target_y      The target Y coordinate.
/// @description Calculates the shortest distance between two points, considering screen wrap.
///              Requires global.play_area_width and global.play_area_height.
/// @returns {real} The shortest wrapped distance.

function scr_wrap_distance_to_point(argument0, argument1, argument2, argument3) {
    var origin_x = argument0;
    var origin_y = argument1;
    var target_x = argument2;
    var target_y = argument3;

    // Calculate initial delta vector
    var dx = target_x - origin_x;
    var dy = target_y - origin_y;

    // Pre-calculate half wrap dimensions
    var half_width = global.play_area_width * 0.5;
    var half_height = global.play_area_height * 0.5;

    // Adjust dx for screen wrap to find the shortest path
    if (abs(dx) > half_width) {
        dx -= sign(dx) * global.play_area_width;
    }
    // Adjust dy for screen wrap
    if (abs(dy) > half_height) {
        dy -= sign(dy) * global.play_area_height;
    }

    // Return the magnitude of the shortest wrapped vector
    return point_distance(0, 0, dx, dy); // or sqrt(sqr(dx) + sqr(dy));
}