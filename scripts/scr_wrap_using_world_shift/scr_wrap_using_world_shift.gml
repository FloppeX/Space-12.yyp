/// @function                scr_wrap_using_world_shift()
/// @description             Checks if the calling instance (e.g., player) has crossed a wrap border
///                          and shifts the entire physics world accordingly to simulate wrapping.
///                          Intended to be called from the player's End Step event.
///                          Uses global.wrap_border_*, global.play_area_*.

function scr_wrap_using_world_shift() {

    var world_shift_x = 0;
    var world_shift_y = 0;
    var needs_shift = false;

    // --- DEBUG: Log current position and borders ---
    // Note: This check now runs at the START of End Step
    if (id == global.player && timer mod 30 == 0) { // Throttle logging
         show_debug_message("World Shift Check: Player Pos=(" + string(floor(phy_position_x)) + "," + string(floor(phy_position_y)) +
                           ") Borders L/R/T/B=(" + string(global.wrap_border_left) + "/" + string(global.wrap_border_right) + "/" +
                           string(global.wrap_border_top) + "/" + string(global.wrap_border_bottom) + ")");
    }

    // Check horizontal wrap
    if (phy_position_x < global.wrap_border_left) {
        // Player went left, shift world LEFT by play_area_width
        world_shift_x = -global.play_area_width;
        needs_shift = true;
         show_debug_message(" --> World Shift Left Triggered! ShiftX=" + string(world_shift_x));
    } else if (phy_position_x > global.wrap_border_right) {
        // Player went right, shift world RIGHT by play_area_width
        world_shift_x = global.play_area_width;
        needs_shift = true;
         show_debug_message(" --> World Shift Right Triggered! ShiftX=" + string(world_shift_x));
    }

    // Check vertical wrap
    if (phy_position_y < global.wrap_border_top) {
        // Player went up, shift world UP by play_area_height
        world_shift_y = -global.play_area_height;
        needs_shift = true;
         show_debug_message(" --> World Shift Top Triggered! ShiftY=" + string(world_shift_y));
    } else if (phy_position_y > global.wrap_border_bottom) {
        // Player went down, shift world DOWN by play_area_height
        world_shift_y = global.play_area_height;
        needs_shift = true;
         show_debug_message(" --> World Shift Bottom Triggered! ShiftY=" + string(world_shift_y));
    }

    // Apply the shift if needed
    if (needs_shift) {
        show_debug_message(" Applying physics_world_shift(" + string(world_shift_x) + ", " + string(world_shift_y) + ")");
        physics_world_shift(world_shift_x, world_shift_y);
        show_debug_message(" World shift applied. Player new effective pos should be wrapped.");

        // Optional: Reset player velocity? Might still be needed to prevent overshoot
        // phy_speed_x = 0;
        // phy_speed_y = 0;
        // phy_angular_velocity = 0;
    }
}