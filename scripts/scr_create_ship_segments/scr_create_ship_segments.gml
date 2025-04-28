/// @function scr_create_ship_segments(number_of_segments, segment_distance, segment_object_or_name)
/// @param {real} number_of_segments   The total number of segments desired.
/// @param {real} segment_distance     The distance between linked segments.
/// @param {Asset.GMObject | String} segment_object_or_name The object index OR object name string of the segment to create.
/// @description Creates a chain of ship segments randomly, starting from the calling instance's position. Populates the caller's 'ship_segment' array using 'self'.

function scr_create_ship_segments(argument0, argument1, argument2) {

    var num_segments = argument0;
    var seg_dist = argument1;
    var target_type; // Use THIS variable to hold the resolved object ID
    var target_type_name = "UNKNOWN"; // For debug

    // --- Corrected Argument Handling ---
    show_debug_message("->> scr_create_ship_segments ENTERED by " + string(self.id) + "(" + object_get_name(self.object_index) + ")");
    // show_debug_message("    Raw argument2 value: " + string(argument2)); // Optional raw value debug

    if (is_string(argument2)) {
        target_type_name = argument2;
        target_type = asset_get_index(target_type_name); // Resolve name string to ID
        show_debug_message("    Resolved NAME [" + target_type_name + "] to ID: " + string(target_type));
    } else {
        target_type = argument2; // Argument was already an object ID
        // Safely get name for debug if it's a valid object ID
        if (target_type >= 0 && asset_get_type(target_type) == asset_object && object_exists(target_type)) {
             target_type_name = object_get_name(target_type);
        }
        show_debug_message("    Received ID: " + string(target_type) + ", name: [" + target_type_name + "]");
    }
    // --- End Argument Handling ---

    // --- Safety Checks (Using resolved target_type) ---
    var _obj_exists = object_exists(target_type); // Check the resolved ID
    show_debug_message("    Result of object_exists(resolved target_type ID " + string(target_type) + "): " + string(_obj_exists));

    if (!_obj_exists) {
        show_debug_message("   scr_create_ship_segments: ERROR - Resolved Segment object check failed! Exiting.");
        exit;
    }
    if (num_segments <= 0) {
        show_debug_message("   scr_create_ship_segments: Warning - num_segments is zero or less. Exiting.");
        exit;
    }
    if (!variable_instance_exists(self.id, "ship_segment") || !is_array(self.ship_segment)) {
         show_debug_message("   scr_create_ship_segments: ERROR - ship_segment array does not exist on caller " + string(self.id) + ". Initializing.");
         self.ship_segment = [];
    } else if (array_length(self.ship_segment) != 0) {
        // show_debug_message("   scr_create_ship_segments: Warning - ship_segment array was not empty. Clearing first.");
        self.ship_segment = []; // Ensure array is clear before starting
    }
    // --- End Safety Checks ---


    // --- Create First Segment ---
    show_debug_message("   Attempting to create segment 0 using object ID: " + string(target_type) + " (" + target_type_name + ")");
    self.ship_segment[0] = instance_create_depth(phy_position_x, phy_position_y, depth, target_type); // Use resolved target_type

    if (!instance_exists(self.ship_segment[0])) {
         show_debug_message("   ERROR: Failed instance create for segment 0! Exiting script.");
         self.ship_segment = [];
         exit;
    } else {
         show_debug_message("   Segment 0 created. Array length now: " + string(array_length(self.ship_segment)));
         self.ship_segment[0].owner = self.id;
         self.ship_segment[0].joint = noone;
    }


    // --- Create Remaining Segments ---
    var segments_created = 1;
    var attempts = 0;
    var max_attempts_per_segment = 50;

    while (segments_created < num_segments) {
        attempts = 0;
        var placed_this_segment = false;

        while (attempts < max_attempts_per_segment) {
            var random_existing_index = irandom(segments_created - 1);
            if (random_existing_index >= array_length(self.ship_segment) || !instance_exists(self.ship_segment[random_existing_index])){
                attempts += 1; continue;
            }
            var existing_seg = self.ship_segment[random_existing_index];

            var random_angle = random_range(200, 340);
            var x_pos = existing_seg.phy_position_x + lengthdir_x(seg_dist, random_angle);
            var y_pos = existing_seg.phy_position_y + lengthdir_y(seg_dist, random_angle);

            var collision = false;
            for (var j = 0; j < segments_created; j += 1) {
                 if (instance_exists(self.ship_segment[j]) && point_distance(x_pos, y_pos, self.ship_segment[j].phy_position_x, self.ship_segment[j].phy_position_y) < seg_dist * 0.8) {
                      collision = true; break;
                 }
            }

            if (!collision) {
                var new_index = segments_created;
                // show_debug_message("   Attempting segment " + string(new_index) + " using object ID: " + string(target_type)); // Less verbose debug
                self.ship_segment[new_index] = instance_create_depth(x_pos, y_pos, depth, target_type); // Use resolved target_type

                if (!instance_exists(self.ship_segment[new_index])) {
                     show_debug_message("   ERROR: Failed instance create for segment " + string(new_index) + ". Retrying placement.");
                     attempts += 1; continue;
                } else {
                    // show_debug_message("   Placed segment at index " + string(new_index) + ". Array length now: " + string(array_length(self.ship_segment)));
                    self.ship_segment[new_index].owner = self.id;
                    self.ship_segment[new_index].joint = noone;
                    segments_created += 1;
                    placed_this_segment = true;
                    // show_debug_message("   SUCCESS placing segment " + string(new_index) + ". Total segments created: " + string(segments_created));
                    break; // Exit attempt loop
                }
            } // End if(!collision)
            attempts += 1;
        } // End attempt loop

        if (!placed_this_segment) {
             show_debug_message("   WARNING: Failed to place segment " + string(segments_created) + ". Stopping generation.");
             break; // Exit main loop
        }
    } // End main segment creation loop

    show_debug_message("-> scr_create_ship_segments EXIT for " + string(self.id) + ". Final array length: " + string(array_length(self.ship_segment)) + ". Segments successfully created: " + string(segments_created));
}