/// @function scr_update_ship_neighbors()
/// @description Calculates and assigns the orthogonal neighbors (top, bottom, left, right)
///              for all segments in the calling ship instance's ship_segment array.
///              This is used for drawing connector sprites.
///              Assumes called from the main ship instance (e.g., obj_player).
///              Requires ship_segment array and segment_distance variable on the caller.

function scr_update_segment_neighbors() {

    show_debug_message("--- Running scr_update_ship_neighbors for " + string(self.id) + " ---");

    // --- Safety Checks ---
    if (!variable_instance_exists(self.id, "ship_segment") || !is_array(self.ship_segment)) {
        show_debug_message("   ERROR: ship_segment array missing or invalid!");
        exit;
    }
    if (!variable_instance_exists(self.id, "segment_distance")) {
        show_debug_message("   ERROR: segment_distance variable missing!");
        exit;
    }
    if (array_length(self.ship_segment) == 0) {
         show_debug_message("   WARN: ship_segment array is empty. No neighbors to calculate.");
         exit;
    }
    // --- End Checks ---

    var _seg_dist = self.segment_distance; // Get segment distance from caller
    var NEIGHBOR_CHECK_DIST_SQ_MAX = sqr(_seg_dist * 1.1); // Use squared distance
    var NEIGHBOR_CHECK_DIST_SQ_MIN = sqr(_seg_dist * 0.9);

    // Loop through each segment to calculate its neighbors
    for (var i = 0; i < array_length(self.ship_segment); i += 1) {
        var _seg_i = self.ship_segment[i];
        if (!scr_exists(_seg_i)) {
             show_debug_message("   Skipping non-existent segment at index " + string(i));
             continue;
        }

        // Initialize/Reset neighbor variables for this segment
        // Ensure variable exists before setting to noone
        if (!variable_instance_exists(_seg_i.id,"neighbor_top")) _seg_i.neighbor_top = noone; else _seg_i.neighbor_top = noone;
        if (!variable_instance_exists(_seg_i.id,"neighbor_bottom")) _seg_i.neighbor_bottom = noone; else _seg_i.neighbor_bottom = noone;
        if (!variable_instance_exists(_seg_i.id,"neighbor_left")) _seg_i.neighbor_left = noone; else _seg_i.neighbor_left = noone;
        if (!variable_instance_exists(_seg_i.id,"neighbor_right")) _seg_i.neighbor_right = noone; else _seg_i.neighbor_right = noone;

        // Inner loop: Check against all other segments
        for (var j = 0; j < array_length(self.ship_segment); j += 1) {
            if (i == j) continue; // Don't check self

            var _seg_j = self.ship_segment[j];
            if (!scr_exists(_seg_j)) continue; // Skip if other segment doesn't exist

            // Calculate vector and squared distance
            var _dx = _seg_j.phy_position_x - _seg_i.phy_position_x;
            var _dy = _seg_j.phy_position_y - _seg_i.phy_position_y;
            var _dist_sq = sqr(_dx) + sqr(_dy);

            // Check if roughly the correct distance away?
            if (_dist_sq > NEIGHBOR_CHECK_DIST_SQ_MIN && _dist_sq < NEIGHBOR_CHECK_DIST_SQ_MAX) {
                // Check if primarily horizontal or vertical offset (allow some tolerance)
                if (abs(_dx) > abs(_dy) * 1.5) { // Horizontal neighbor?
                    if (_dx > 0) {
                        _seg_i.neighbor_right = _seg_j;
                    } else {
                        _seg_i.neighbor_left = _seg_j;
                    }
                } else if (abs(_dy) > abs(_dx) * 1.5) { // Vertical neighbor?
                    if (_dy > 0) { // Assuming +Y is down
                        _seg_i.neighbor_bottom = _seg_j;
                    } else {
                        _seg_i.neighbor_top = _seg_j;
                    }
                }
                // Ignore diagonal connections for drawing purposes
            } // End if distance matches
        } // End inner loop (j)

        // Optional Debug: Check assigned values for this segment
        // show_debug_message(" Segment " + string(i) + " Final Neighbors: T=" + string(_seg_i.neighbor_top) + " B=" + string(_seg_i.neighbor_bottom) + " L=" + string(_seg_i.neighbor_left) + " R=" + string(_seg_i.neighbor_right));

    } // End outer loop (i)

     show_debug_message("--- Finished scr_update_ship_neighbors for " + string(self.id) + " ---");
}
