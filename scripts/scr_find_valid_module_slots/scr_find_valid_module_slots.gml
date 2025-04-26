/// @function scr_find_valid_module_slots(ship_instance_id, module_to_place)
/// @param {Id.Instance} ship_instance_id  The ID of the ship being built.
/// @param {Id.Instance} module_to_place   The module instance we want to find a slot for.
/// @description Finds all empty segment indices on the ship where the given module can be placed.
/// @returns {Id.DsList} A DS List containing the indices (0, 1, 2...) of valid segments. Returns empty list if none found.

function scr_find_valid_module_slots(argument0, argument1) {
    var _ship = argument0;
    var _module = argument1;
    var _valid_slot_list = ds_list_create();

    if (!instance_exists(_ship) || !instance_exists(_module)) {
        return _valid_slot_list; // Return empty list if inputs invalid
    }

    for (var i = 0; i < array_length(_ship.ship_segment); i += 1;) {
        var _segment = _ship.ship_segment[i];
        // Check if segment exists, is empty, AND meets placement requirements
        if (scr_exists(_segment) && _segment.module == noone && scr_check_module_placement(_module, _segment)) {
            ds_list_add(_valid_slot_list, i); // Add the index 'i' to the list
        }
    }

    return _valid_slot_list;
}