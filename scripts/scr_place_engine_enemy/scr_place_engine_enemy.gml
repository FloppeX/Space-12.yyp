/// @function scr_place_engine_enemy(engine_module_object)
/// @param engine_module_object The object type of the engine to place.
/// @description Places the specified engine module in ANY valid empty slot using scr_find_valid_module_slots.
///              Assumes called from the ship instance. Requires ship_segment array.
/// @returns {boolean} True if an engine was successfully placed, false otherwise.

function scr_place_engine_enemy(argument0) {
    var engine_type = argument0;
    var engine_placed = false;

    // Safety Check: Ensure ship instance and segment array exist and are valid
    if (!instance_exists(id) || !variable_instance_exists(id, "ship_segment") || !is_array(ship_segment)) {
        show_debug_message("ERROR in scr_place_engine_enemy: Invalid instance or ship_segment array for " + string(id));
        return false;
    }

    // Create temporary engine instance to check placement requirements
    // Ensure engine_type is a valid object before creating
    if (!object_exists(engine_type)) {
         show_debug_message("ERROR in scr_place_engine_enemy: Invalid engine_type object " + string(engine_type));
         return false;
    }
    var temp_engine = instance_create_depth(0, 0, -10, engine_type);
    if (!instance_exists(temp_engine)) {
         show_debug_message("ERROR in scr_place_engine_enemy: Failed to create temp engine " + object_get_name(engine_type));
         return false;
    }
    temp_engine.owner = id; // Set owner early if needed for checks

    // Find all valid empty slots for this engine using the helper script
    var valid_slots = scr_find_valid_module_slots(id, temp_engine);
    var num_valid_slots = ds_list_size(valid_slots);

    if (num_valid_slots > 0) {
        // Found at least one valid slot. Pick one randomly.
        // (Could add logic here to prefer rear slots if desired, but let's ensure placement first)
        ds_list_shuffle(valid_slots);
        var chosen_segment_index = valid_slots[| 0];

        // Check if the chosen segment still exists (extra safety)
        if (chosen_segment_index < array_length(ship_segment) && scr_exists(ship_segment[chosen_segment_index]) && ship_segment[chosen_segment_index].module == noone) {
            var target_segment = ship_segment[chosen_segment_index];

            // Place the engine module
            target_segment.module = temp_engine;
            temp_engine.ship_segment = target_segment;
            // Owner already set
            // Position/joint handled later in the main Create Event loop
            engine_placed = true;
            show_debug_message("scr_place_engine_enemy: Placed " + object_get_name(engine_type) + " in segment " + string(chosen_segment_index) + " for ship " + string(id));
        } else {
             show_debug_message("WARN in scr_place_engine_enemy: Chosen segment " + string(chosen_segment_index) + " was invalid/filled unexpectedly for ship " + string(id));
             instance_destroy(temp_engine); // Destroy if segment became invalid
             engine_placed = false;
        }
    }

    // Clean up the list
    ds_list_destroy(valid_slots);

    // If no valid slot was found OR placement failed unexpectedly, destroy the temporary engine instance
    if (!engine_placed && instance_exists(temp_engine)) { // Check instance_exists before destroy
        instance_destroy(temp_engine);
        show_debug_message("WARN: scr_place_engine_enemy could not find any valid slot for " + object_get_name(engine_type) + " on ship " + string(id));
    }

    return engine_placed; // Return success/failure
}