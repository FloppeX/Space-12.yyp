/// @function scr_place_engine_player()
/// @description Places the player's starting engine (obj_module_engine_small)
///              in the valid empty slot furthest to the "rear" (minimum relative X).
///              Uses scr_find_valid_module_slots. Returns true if placed, false otherwise.

function scr_place_engine_player() {
    var engine_type = obj_module_engine_small; // Player starting engine type
    var engine_placed = false;
    var best_seg_index = -1;
    var min_relative_x = infinity; // Find the smallest relative X (Geometric Left = Ship Rear)

    // Safety Check: Ensure ship_segment array exists
    if (!variable_instance_exists(id, "ship_segment") || !is_array(ship_segment)) {
        show_debug_message("ERROR in scr_place_engine_player: ship_segment array missing for " + string(id));
        return false;
    }

    // Create temporary engine instance to check placement requirements
    if (!object_exists(engine_type)) { show_debug_message("ERROR: Engine type " + string(engine_type) + " not found!"); return false; }
    var temp_engine = instance_create_depth(0, 0, 0, engine_type);
    if (!instance_exists(temp_engine)) { show_debug_message("ERROR: Failed to create temp engine!"); return false; }
    temp_engine.owner = id;

    // Find *all* valid empty slots for this engine type
    var valid_slots = scr_find_valid_module_slots(id, temp_engine);
    var num_valid = ds_list_size(valid_slots);

    show_debug_message("scr_place_engine_player: Found " + string(num_valid) + " valid slots for engine.");

    if (num_valid > 0) {
        // Iterate through the list of VALID slots to find the best one (minimum relative X)
        for (var i = 0; i < num_valid; i++) {
            var seg_index = valid_slots[| i];

            // Double check segment exists and index is valid
            if (seg_index < array_length(ship_segment) && scr_exists(ship_segment[seg_index])) {
                var _seg = ship_segment[seg_index];
                // Calculate X relative to ship center
                var relative_x = _seg.phy_position_x - phy_position_x;

                if (relative_x < min_relative_x) {
                     min_relative_x = relative_x;
                     best_seg_index = seg_index;
                }
            }
        } // End loop through valid slots

        // Place engine if a best slot was determined
        if (best_seg_index != -1) {
             var target_segment = ship_segment[best_seg_index];
             if (target_segment.module == noone) { // Double check empty
                 target_segment.module = temp_engine;
                 temp_engine.ship_segment = target_segment;
                 engine_placed = true;
                 show_debug_message("scr_place_engine_player: Placed engine in segment " + string(best_seg_index) + " with relative X " + string(min_relative_x));
             } else { show_debug_message("WARN: Best slot for engine (" + string(best_seg_index) + ") was already filled!"); }
        } else { show_debug_message("WARN: Could not determine best rear segment from valid slots."); }
    } // End if (num_valid > 0)

    // Clean up list
    ds_list_destroy(valid_slots);

    // If engine wasn't placed successfully, destroy the temporary instance
    if (!engine_placed && instance_exists(temp_engine)) {
        instance_destroy(temp_engine);
        show_debug_message("WARN: scr_place_engine_player did not place an engine.");
    }

    return engine_placed; // Return success/failure
}