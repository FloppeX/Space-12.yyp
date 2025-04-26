/// @function                scr_wrap_room_ship_new()
/// @description             Wraps the calling ship instance (and its attached segments/modules)
///                          around the play area defined by global wrap borders.
///                          Requires ship_segment array on the caller.
///                          Uses global.wrap_border_*, global.play_area_*.

function scr_wrap_room_ship_new() {

    // Use local variables (prefixing with _ is good practice)
    var _wrap_offset_x = 0;
    var _wrap_offset_y = 0;

    // Check if the main ship object needs to wrap horizontally
    if (phy_position_x < global.wrap_border_left) {
        _wrap_offset_x = global.play_area_width;
    } else if (phy_position_x > global.wrap_border_right) {
        _wrap_offset_x = -global.play_area_width;
    }

    // Check if the main ship object needs to wrap vertically
    if (phy_position_y < global.wrap_border_top) {
        _wrap_offset_y = global.play_area_height;
    } else if (phy_position_y > global.wrap_border_bottom) {
        _wrap_offset_y = -global.play_area_height;
    }

    // If no wrapping is needed, exit early
    if (_wrap_offset_x == 0 && _wrap_offset_y == 0) {
        exit;
    }

    // Apply the wrap offset to the main ship body (the instance calling the script)
    phy_position_x += _wrap_offset_x;
    phy_position_y += _wrap_offset_y;

    // Apply the *same* offset to all attached segments and their modules
    for (var i = 0; i < array_length(ship_segment); i += 1;) {
        if (scr_exists(ship_segment[i])) {
            // Use 'with' to apply changes directly to the segment instance
            with (ship_segment[i]) {
                // Access the SCRIPT'S local variables DIRECTLY (no 'other.')
                phy_position_x += _wrap_offset_x;
                phy_position_y += _wrap_offset_y;

                // Also apply offset to the module attached to this segment, if it exists
                if (scr_exists(module)) {
                    with (module) {
                        // Access the SCRIPT'S local variables DIRECTLY (no 'other.')
                        phy_position_x += _wrap_offset_x;
                        phy_position_y += _wrap_offset_y;
                    }
                }
            }
        }
    }
}