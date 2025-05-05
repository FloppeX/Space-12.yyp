/// @function scr_update_segment_neighbors()
/// @description Calculates and assigns the orthogonal neighbors (top, bottom, left, right)
///              for all segments in the calling ship instance's ship_segment array,
///              independent of the ship's current rotation.
///              Uses neighbor_top/bottom/left/right variables.
///              Assumes called from the main ship instance (e.g., obj_player).
///              Requires ship_segment array and segment_distance variable on the caller.

function scr_update_segment_neighbors() {

    show_debug_message("--- Running scr_update_ship_neighbors for " + string(self.id) + " (Rotation Independent) ---");

    // --- Safety Checks ---
    if (!variable_instance_exists(self.id, "ship_segment") || !is_array(self.ship_segment)) { show_debug_message("   ERROR: ship_segment array missing!"); exit; }
    if (!variable_instance_exists(self.id, "segment_distance")) { show_debug_message("   ERROR: segment_distance variable missing!"); exit; }
    if (array_length(self.ship_segment) == 0) { show_debug_message("   WARN: ship_segment array is empty."); exit; }
    // --- End Checks ---

    var _seg_dist = self.segment_distance;
    var NEIGHBOR_CHECK_DIST_SQ_MAX = sqr(_seg_dist * 1.1); // Squared distance tolerance
    var NEIGHBOR_CHECK_DIST_SQ_MIN = sqr(_seg_dist * 0.9);
    var ship_inverse_rotation = -self.phy_rotation; // Calculate inverse rotation once

    // Loop through each segment to calculate its neighbors
    for (var i = 0; i < array_length(self.ship_segment); i += 1) {
        var _seg_i = self.ship_segment[i];
        if (!scr_exists(_seg_i)) { continue; }

        // Initialize/Reset neighbor variables
        if (!variable_instance_exists(_seg_i.id,"neighbor_top")) _seg_i.neighbor_top = noone; else _seg_i.neighbor_top = noone;
        if (!variable_instance_exists(_seg_i.id,"neighbor_bottom")) _seg_i.neighbor_bottom = noone; else _seg_i.neighbor_bottom = noone;
        if (!variable_instance_exists(_seg_i.id,"neighbor_left")) _seg_i.neighbor_left = noone; else _seg_i.neighbor_left = noone;
        if (!variable_instance_exists(_seg_i.id,"neighbor_right")) _seg_i.neighbor_right = noone; else _seg_i.neighbor_right = noone;

        // Inner loop: Check against all other segments
        for (var j = 0; j < array_length(self.ship_segment); j += 1) {
            if (i == j) continue; // Don't check self

            var _seg_j = self.ship_segment[j];
            if (!scr_exists(_seg_j)) continue;

            // --- Calculate vector in WORLD space ---
            var _world_dx = _seg_j.phy_position_x - _seg_i.phy_position_x;
            var _world_dy = _seg_j.phy_position_y - _seg_i.phy_position_y;
            var _dist_sq = sqr(_world_dx) + sqr(_world_dy);

            // Check if roughly the correct distance away
            if (_dist_sq > NEIGHBOR_CHECK_DIST_SQ_MIN && _dist_sq < NEIGHBOR_CHECK_DIST_SQ_MAX) {

                // --- Convert world vector to SHIP'S LOCAL space ---
                // Rotate the world vector by the inverse of the ship's rotation
                var _local_dx = (_world_dx * dcos(ship_inverse_rotation)) - (_world_dy * dsin(ship_inverse_rotation));
                var _local_dy = (_world_dx * dsin(ship_inverse_rotation)) + (_world_dy * dcos(ship_inverse_rotation));

                // --- Check LOCAL vector direction ---
                // Allow some tolerance for floating point inaccuracies
                var tolerance = 0.1;
                if (abs(_local_dx) > _seg_dist * 0.8 && abs(_local_dy) < _seg_dist * tolerance) { // Primarily Horizontal in local space?
                    if (_local_dx > 0) { _seg_i.neighbor_right = _seg_j; } // Local Right (+X)
                    else { _seg_i.neighbor_left = _seg_j; } // Local Left (-X)
                } else if (abs(_local_dy) > _seg_dist * 0.8 && abs(_local_dx) < _seg_dist * tolerance) { // Primarily Vertical in local space?
                    if (_local_dy > 0) { _seg_i.neighbor_bottom = _seg_j; } // Local Down (+Y)
                    else { _seg_i.neighbor_top = _seg_j; } // Local Up (-Y)
                }
                // Else: It's diagonal in local space, ignore as neighbor for drawing bars
            } // End if distance matches
        } // End inner loop (j)

         // Optional Debug: Check assigned values
         // show_debug_message(" Segment " + string(i) + " Final Neighbors: T=" + string(_seg_i.neighbor_top) + " B=" + string(_seg_i.neighbor_bottom) + " L=" + string(_seg_i.neighbor_left) + " R=" + string(_seg_i.neighbor_right));

    } // End outer loop (i)

     show_debug_message("--- Finished scr_update_ship_neighbors for " + string(self.id) + " ---");
}
