/// @function scr_ship_update_segments(ship_instance_id, segment_distance)
/// @param {Id.Instance} ship_instance_id The ID of the ship (e.g., 'id' from the ship object).
/// @param {real} segment_distance The desired distance between segments.
/// @description Updates segment neighbors, recalculates relative positions based on center of mass,
///              and potentially recreates weld joints. Includes division by zero check.

function scr_ship_update_segments(argument0, argument1) {

    var ship_id = argument0;
    var seg_dist = argument1;

    // --- Safety Check: Ensure ship instance and segment array exist ---
    if (!instance_exists(ship_id) || !variable_instance_exists(ship_id, "ship_segment") || !is_array(ship_id.ship_segment)) {
        show_debug_message("ERROR in scr_ship_update_segments: Invalid ship ID or ship_segment array.");
        exit;
    }

    var _ship_segments = ship_id.ship_segment;
    var _segments_count = 0;
    var center_x = 0;
    var center_y = 0;

    // First pass: Count valid segments and sum positions for CoM
    for (var i = 0; i < array_length(_ship_segments); i++) {
        var _seg = _ship_segments[i];
        if (scr_exists(_seg)) {
            center_x += _seg.phy_position_x;
            center_y += _seg.phy_position_y;
            _segments_count += 1;
        }
    }

    // Prevent Division by Zero
    if (_segments_count == 0) {
        show_debug_message("WARN in scr_ship_update_segments: No valid segments found for ship " + string(ship_id) + ". Exiting.");
        exit;
    }

    // Calculate average position (Center of Mass)
    var average_x = center_x / _segments_count;
    var average_y = center_y / _segments_count;

    // --- Update segments based on calculated CoM and neighbors ---
    // (Assuming neighbor update logic might exist elsewhere or isn't strictly needed if joints are strong)

    // Second pass: Update positions (optional?) and recreate joints
    for (var i = 0; i < array_length(_ship_segments); i++) {
        var _seg = _ship_segments[i];
        if (scr_exists(_seg)) {

            // --- Optional: Reposition based on CoM/Placement Angle? ---
            // Consider if this is necessary or if physics should handle positioning via joints.
            // Directly setting phy_position_* here can cause issues if done frequently with active physics.
            // var target_x = average_x + lengthdir_x(_seg.placement_distance, _seg.placement_angle);
            // var target_y = average_y + lengthdir_y(_seg.placement_distance, _seg.placement_angle);
            // _seg.phy_position_x = target_x;
            // _seg.phy_position_y = target_y;
            // --- End Optional Reposition ---


            // --- Joint Recreation / Handling ---
            // *** CORRECTED CHECK ***
            // Destroy existing weld joint ONLY if the 'joint' variable exists AND it's not already 'noone'
            if (variable_instance_exists(_seg.id, "joint") && _seg.joint != noone) {
                 physics_joint_delete(_seg.joint); // Attempt deletion
                 _seg.joint = noone; // Reset variable after deletion attempt
            } else if (!variable_instance_exists(_seg.id, "joint")) {
                 // If the variable didn't even exist, create it and set to noone
                 _seg.joint = noone;
            }

            // Create NEW weld joint connecting the segment to the main ship body (ship_id)
            // Consider if this should only happen ONCE during initial setup, not every time this script runs.
            // Recreating joints frequently can be unstable.
            if (_seg.joint == noone) { // Only create if we don't think one exists
                _seg.joint = physics_joint_weld_create(ship_id, _seg, _seg.phy_position_x, _seg.phy_position_y, 0, 10000, 10000, false);
                 if (_seg.joint < 0) { // Check if joint creation failed (returns negative value on failure)
                      show_debug_message("WARN: Failed to create weld joint for segment " + string(_seg.id));
                      _seg.joint = noone; // Ensure it's noone if failed
                 }
            }

            // --- Module Position Update ---
             if (scr_exists(_seg.module)) {
                  // Usually handled by the revolute joint, but ensures visual alignment
                  _seg.module.phy_position_x = _seg.phy_position_x;
                  _seg.module.phy_position_y = _seg.phy_position_y;
             }
        }
    } // End loop

    // Update the main ship body's position to the CoM? Optional.
    // ship_id.phy_position_x = average_x;
    // ship_id.phy_position_y = average_y;
}