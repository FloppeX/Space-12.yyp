/// @function scr_create_ship_segments_NEW(num_segments, segment_distance, segment_object_or_name)
/// @param {real} num_segments   The total number of segments desired.
/// @param {real} segment_distance     The distance between linked segments (used for placement offset).
/// @param {Asset.GMObject | String} segment_object_or_name The object index OR object name string of the segment to create.
/// @description Creates a chain of ship segments using orthogonal placement adjacent to existing segments,
///              starting from the calling instance's position. Uses instance_place for collision checks.
///              Populates the caller's 'ship_segment' array using 'self'.

function scr_create_ship_segments_NEW(argument0, argument1, argument2) {
    var num_segments = argument0;
    var seg_dist = argument1;
    var resolved_seg_obj_id; // Use THIS variable to hold the numeric object ID
    var seg_obj_name = "UNKNOWN"; // For debug

    // --- Corrected Argument Handling ---
    show_debug_message("->> scr_create_ship_segments_NEW ENTERED by " + string(self.id) + "(" + object_get_name(self.object_index) + ")");
    // show_debug_message("    Raw argument2 value: " + string(argument2)); // Optional raw value debug

    if (is_string(argument2)) {
        seg_obj_name = argument2;
        resolved_seg_obj_id = asset_get_index(seg_obj_name); // Resolve name string to ID
        show_debug_message("    Resolved NAME [" + seg_obj_name + "] to ID: " + string(resolved_seg_obj_id));
    } else {
        resolved_seg_obj_id = argument2; // Argument was already an object ID
        // Safely get name for debug if it's a valid object ID
        if (resolved_seg_obj_id >= 0 && asset_get_type(resolved_seg_obj_id) == asset_object && object_exists(resolved_seg_obj_id)) {
             seg_obj_name = object_get_name(resolved_seg_obj_id);
        }
        show_debug_message("    Received ID: " + string(resolved_seg_obj_id) + ", name: [" + seg_obj_name + "]");
    }
    // --- End Argument Handling ---


    // --- Safety Checks (Using resolved_seg_obj_id) ---
    var _obj_exists = object_exists(resolved_seg_obj_id); // Check the resolved ID
    show_debug_message("    Result of object_exists(resolved ID " + string(resolved_seg_obj_id) + "): " + string(_obj_exists));

    if (!_obj_exists) {
        show_debug_message("   scr_create_ship_segments_NEW: ERROR - Resolved Segment object check failed! Exiting.");
        exit;
    }
    if (num_segments <= 0) { show_debug_message("   WARN: num_segments <= 0. Exiting."); exit; }
    // Ensure array exists and is clear, using self
    if (!variable_instance_exists(self.id, "ship_segment") || !is_array(self.ship_segment)) { self.ship_segment = []; }
    else if (array_length(self.ship_segment) != 0) { self.ship_segment = []; }
    // --- End Checks ---


    // --- Create First Segment ---
    // Use the resolved resolved_seg_obj_id here!
    show_debug_message("   Attempting to create segment 0 using object ID: " + string(resolved_seg_obj_id) + " (" + seg_obj_name + ")");
    self.ship_segment[0] = instance_create_depth(phy_position_x, phy_position_y, depth, resolved_seg_obj_id); // Use resolved ID
    if (!instance_exists(self.ship_segment[0])) { show_debug_message("   ERROR: Failed instance create for segment 0! Exiting."); self.ship_segment = []; exit; }
    show_debug_message("   Segment 0 created (NEW). Array length: 1");
    self.ship_segment[0].owner = self.id;
    self.ship_segment[0].joint = noone;


    // --- Create Remaining Segments ---
    var segments_created = 1;
    var repeat_times = 10; // Max placement attempts per adjacent spot
    var total_attempts = 0;
    var max_total_attempts = num_segments * repeat_times * 5; // Increased overall safety break slightly

    for (var i = 1; i < num_segments; i += 1) { // Loop to create segments 1 to num_segments-1
        var placed_this_segment = false;
        var main_attempts = 0;
        var max_main_attempts = 50; // Safety break for picking an existing segment to branch from

        while (!placed_this_segment && main_attempts < max_main_attempts && total_attempts < max_total_attempts) {
            // Pick a random existing segment to branch from
            var r = irandom(segments_created - 1);
             if (r >= array_length(self.ship_segment) || !instance_exists(self.ship_segment[r])){ main_attempts++; total_attempts++; continue; } // Safety
            var existing_seg = self.ship_segment[r];

            // Try placing adjacent orthogonally up to 'repeat_times'
            for (var j = 0; j < repeat_times; j += 1) {
                total_attempts++;
                var angle = choose(0, 90, 180, 270); // Orthogonal direction
                var x_pos = existing_seg.phy_position_x + lengthdir_x(seg_dist, angle);
                var y_pos = existing_seg.phy_position_y + lengthdir_y(seg_dist, angle);

                // Check collision using instance_place with the resolved object ID
                if (!instance_place(x_pos, y_pos, resolved_seg_obj_id)) {
                    var new_index = segments_created;
                    // Use the resolved object ID for creation
                    self.ship_segment[new_index] = instance_create_depth(x_pos, y_pos, depth, resolved_seg_obj_id);

                    if (instance_exists(self.ship_segment[new_index])) {
                        self.ship_segment[new_index].owner = self.id;
                        self.ship_segment[new_index].joint = noone;
                        segments_created += 1;
                        placed_this_segment = true;
                        // show_debug_message("   SUCCESS placing segment " + string(new_index) + " orthogonally (NEW). Total: " + string(segments_created));
                        break; // Exit the inner placement attempt loop (for j)
                    } else {
                        show_debug_message("   ERROR: Failed instance create for segment " + string(new_index) + " (NEW).");
                        // No break, will retry placement
                    }
                } // End if (!instance_place)
            } // End inner placement attempt loop (for j)

            if (placed_this_segment) {
                 break; // Exit the outer loop (while !placed)
            }
            main_attempts++; // Increment outer attempts if inner loop failed
        } // End outer loop (while !placed)

        if (!placed_this_segment) {
            show_debug_message("   WARNING: Failed to place segment " + string(segments_created) + " (NEW) after multiple attempts. Stopping generation.");
            break; // Stop trying to place more segments
        }
        if (total_attempts >= max_total_attempts) {
             show_debug_message("   ERROR: Hit max total attempts in segment creation (NEW). Stopping.");
             break;
        }
    } // End main segment creation loop (for i)

    show_debug_message("-> scr_create_ship_segments_NEW EXIT for " + string(self.id) + ". Final array length: " + string(array_length(self.ship_segment)) + ". Segments successfully created: " + string(segments_created));
}