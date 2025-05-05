/// @function                scr_wrap_room_ship_new()
/// @description             Wraps the calling ship instance (and its attached segments/modules)
///                          around the play area defined by global wrap borders.
///                          Temporarily deletes and recreates physics joints during the wrap.
///                          Resets module angular velocity but RETAINS module angle.
///                          Intended to be called in the End Step event. (DEBUG VERSION)

function scr_wrap_room_ship_new() {

    var _wrap_offset_x = 0;
    var _wrap_offset_y = 0;
    var _needs_wrap = false;

    // --- Determine which borders to use ---
    var _border_left, _border_right, _border_top, _border_bottom;
    var _is_player = (id == global.player);
    if (_is_player) {
        _border_left = global.wrap_border_left_player; _border_right = global.wrap_border_right_player;
        _border_top = global.wrap_border_top_player; _border_bottom = global.wrap_border_bottom_player;
    } else {
        _border_left = global.wrap_border_left; _border_right = global.wrap_border_right;
        _border_top = global.wrap_border_top; _border_bottom = global.wrap_border_bottom;
    }

    // --- DEBUG: Log current position and determined borders ---
    if (_is_player && timer mod 60 == 0) {
         show_debug_message("Wrap Check: Player Pos=(" + string(floor(phy_position_x)) + "," + string(floor(phy_position_y)) +
                           ") Borders L/R/T/B=(" + string(_border_left) + "/" + string(_border_right) + "/" +
                           string(_border_top) + "/" + string(_border_bottom) + ")");
    }

    // Check horizontal wrap
    if (phy_position_x < _border_left) {
        _wrap_offset_x = global.play_area_width; _needs_wrap = true;
         show_debug_message(" --> Wrap Left Triggered! OffsetX=" + string(_wrap_offset_x));
    } else if (phy_position_x > _border_right) {
        _wrap_offset_x = -global.play_area_width; _needs_wrap = true;
         show_debug_message(" --> Wrap Right Triggered! OffsetX=" + string(_wrap_offset_x));
    }
    // Check vertical wrap
    if (phy_position_y < _border_top) {
        _wrap_offset_y = global.play_area_height; _needs_wrap = true;
         show_debug_message(" --> Wrap Top Triggered! OffsetY=" + string(_wrap_offset_y));
    } else if (phy_position_y > _border_bottom) {
        _wrap_offset_y = -global.play_area_height; _needs_wrap = true;
         show_debug_message(" --> Wrap Bottom Triggered! OffsetY=" + string(_wrap_offset_y));
    }

    // Exit if no wrap needed
    if (!_needs_wrap) { exit; }

    // --- Proceed with Delete-Move-Recreate Logic ---
    show_debug_message(" Wrap Action: Preparing to delete joints...");
    var _can_delete_and_move = false;
    if (variable_instance_exists(id,"ship_segment") && is_array(ship_segment) && array_length(ship_segment) > 0) {
        _can_delete_and_move = true;
    } else {
         show_debug_message("  WARN: ship_segment array missing or empty! Cannot wrap structure.");
    }

    // 1. Delete Existing Joints
    if (_can_delete_and_move) {
         show_debug_message("  Starting joint deletion loop...");
        for (var i = 0; i < array_length(ship_segment); i += 1;) {
             var _seg = ship_segment[i];
             if (scr_exists(_seg)) {
                 if (scr_exists(_seg.module)) {
                     var _module = _seg.module;
                     if (variable_instance_exists(_module.id, "joint") && _module.joint != noone) { physics_joint_delete(_module.joint); _module.joint = noone; }
                 }
                 if (variable_instance_exists(_seg.id, "joint") && _seg.joint != noone) { physics_joint_delete(_seg.joint); _seg.joint = noone; }
             }
         }
         show_debug_message("  Finished joint deletion.");
    }

    show_debug_message("  Pos BEFORE wrap: (" + string(floor(phy_position_x)) + "," + string(floor(phy_position_y)) + ")");

    // 2. Move All Parts
    phy_position_x += _wrap_offset_x;
    phy_position_y += _wrap_offset_y;
    if (_can_delete_and_move) {
        for (var i = 0; i < array_length(ship_segment); i += 1;) {
             var _seg = ship_segment[i];
             if (scr_exists(_seg)) {
                 _seg.phy_position_x += _wrap_offset_x;
                 _seg.phy_position_y += _wrap_offset_y;
                 // Reset segment angular velocity (optional, but good practice)
                 _seg.phy_angular_velocity = 0;

                 if (scr_exists(_seg.module)) {
                     var _module = _seg.module;
                     _module.phy_position_x += _wrap_offset_x;
                     _module.phy_position_y += _wrap_offset_y;
                     // Reset module angular velocity to prevent post-wrap spin speed
                     _module.phy_angular_velocity = 0;
                 }
             }
         }
    }
    show_debug_message("  Pos AFTER wrap (Main Body): (" + string(floor(phy_position_x)) + "," + string(floor(phy_position_y)) + ")");
    show_debug_message("  Repositioning complete. Recreating joints...");


    // 3. Recreate Joints
    if (_can_delete_and_move) {
        for (var i = 0; i < array_length(ship_segment); i += 1) {
             var _seg = ship_segment[i];
             if (scr_exists(_seg)) {
                 // Recreate Weld Joint
                 if (!variable_instance_exists(_seg.id, "joint")) { _seg.joint = noone; }
                 if (_seg.joint == noone) {
                     _seg.joint = physics_joint_weld_create(self.id, _seg, _seg.phy_position_x, _seg.phy_position_y, 0, 10000, 1, false);
                      if (_seg.joint < 0) { show_debug_message("    WARN: Failed RECREATE weld joint seg " + string(_seg.id)); _seg.joint = noone; }
                 }
                 // Recreate Module Revolute Joint
                 if (scr_exists(_seg.module)) {
                     var _module = _seg.module;
                     if (!variable_instance_exists(_module.id, "joint")) { _module.joint = noone; }
                     if (_module.joint == noone) {
                         // --- DO NOT SET phy_rotation here ---
                         // Let the module retain its angle from before the wrap

                         // Create free spinning joint (motor disabled by default)
                         _module.joint = physics_joint_revolute_create(_seg, _module, _module.phy_position_x, _module.phy_position_y, 0, 0, false, 0, 0, false, false);

                          if (_module.joint < 0) {
                              show_debug_message("    WARN: Failed RECREATE revolute joint module " + string(_module.id));
                              _module.joint = noone;
                          }
                          // Motor activation is handled by obj_module Step_0 event
                     }
                 }
             }
         }
         show_debug_message("    Finished recreating joints.");
    }

	self.just_wrapped = true; // flag that a wrap just happened

    show_debug_message("<<< scr_wrap_room_ship_new finished (delete/move/recreate - RETAIN angle).");
}
