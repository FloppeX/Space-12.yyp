/// @function                scr_teleport_ship(x_offset, y_offset)
/// @param {real} x_offset   The amount to shift horizontally.
/// @param {real} y_offset   The amount to shift vertically.
/// @description             Teleports the calling ship instance (and its attached segments/modules)
///                          by the specified offset. Temporarily deletes and recreates physics joints.
///                          Assumes called from the main ship instance (e.g., obj_player).

function scr_teleport_ship(argument0, argument1) {

    var _teleport_offset_x = argument0;
    var _teleport_offset_y = argument1;

    // Exit if no offset provided
    if (_teleport_offset_x == 0 && _teleport_offset_y == 0) {
        exit;
    }

    show_debug_message(">>> scr_teleport_ship triggered for " + string(self.id) + " with offset (" + string(_teleport_offset_x) + "," + string(_teleport_offset_y) + ")");
    show_debug_message("    Deleting joints...");

    // --- 1. Delete Existing Joints ---
    if (variable_instance_exists(self.id,"ship_segment") && is_array(self.ship_segment)) {
        for (var i = 0; i < array_length(self.ship_segment); i += 1;) {
            var _seg = self.ship_segment[i];
            if (scr_exists(_seg)) {
                // Delete module joint first
                if (scr_exists(_seg.module)) {
                    var _module = _seg.module;
                    if (variable_instance_exists(_module.id, "joint") && _module.joint != noone) {
                        physics_joint_delete(_module.joint);
                        _module.joint = noone;
                    }
                }
                // Delete segment joint
                if (variable_instance_exists(_seg.id, "joint") && _seg.joint != noone) {
                    physics_joint_delete(_seg.joint);
                    _seg.joint = noone;
                }
            }
        }
         show_debug_message("    Joint deletion loop finished.");
    } else {
         show_debug_message("    WARN: ship_segment array missing or invalid during joint deletion!");
    }


    show_debug_message("    Pos BEFORE teleport: (" + string(floor(self.phy_position_x)) + "," + string(floor(self.phy_position_y)) + ")");

    // --- 2. Move All Parts ---
    // Apply offset to main ship body
    self.phy_position_x += _teleport_offset_x;
    self.phy_position_y += _teleport_offset_y;

    // Apply the *same* offset to all attached segments and their modules
    if (variable_instance_exists(self.id,"ship_segment") && is_array(self.ship_segment)) {
        for (var i = 0; i < array_length(self.ship_segment); i += 1;) {
            var _seg = self.ship_segment[i];
            if (scr_exists(_seg)) {
                _seg.phy_position_x += _teleport_offset_x;
                _seg.phy_position_y += _teleport_offset_y;
                if (scr_exists(_seg.module)) {
                    var _module = _seg.module;
                    _module.phy_position_x += _teleport_offset_x;
                    _module.phy_position_y += _teleport_offset_y;
                }
            }
        }
    }
    show_debug_message("    Pos AFTER teleport (Main Body): (" + string(floor(self.phy_position_x)) + "," + string(floor(self.phy_position_y)) + ")");
    show_debug_message("    Repositioning complete. Recreating joints...");


    // --- 3. Recreate Joints (Copied from Create Event final loop logic) ---
    var _is_enemy = object_is_ancestor(self.object_index, obj_enemy_ship); // Check if enemy

    if (variable_instance_exists(self.id,"ship_segment") && is_array(self.ship_segment)) {
        for (var i = 0; i < array_length(self.ship_segment); i += 1) {
            var _seg = self.ship_segment[i];
            if (scr_exists(_seg)) {

                // Recreate Weld Joint (Segment to Body)
                if (!variable_instance_exists(_seg.id, "joint")) { _seg.joint = noone; }
                if (_seg.joint == noone) {
                    // Use self.id to refer to the calling ship instance
                    _seg.joint = physics_joint_weld_create(self.id, _seg, _seg.phy_position_x, _seg.phy_position_y, 0, 10000, 1, false);
                     if (_seg.joint < 0) { show_debug_message("    WARN: Failed RECREATE weld joint seg " + string(_seg.id)); _seg.joint = noone; }
                }

                // Recreate Module Revolute Joint (Module to Segment)
                if (scr_exists(_seg.module)) {
                    var _module = _seg.module;
                    if (!variable_instance_exists(_module.id, "joint")) { _module.joint = noone; }
                    if (_module.joint == noone) {
                        var _initial_module_angle = -self.phy_rotation + _module.offset_angle;
                        while (_initial_module_angle >= 360) { _initial_module_angle -= 360; } while (_initial_module_angle < 0) { _initial_module_angle += 360; }
                        _module.phy_rotation = _initial_module_angle;
                        // Use free spinning joint
                        _module.joint = physics_joint_revolute_create(_seg, _module, _module.phy_position_x, _module.phy_position_y, 0, 0, false, 0, 0, false, false);
                         if (_module.joint < 0) { show_debug_message("    WARN: Failed RECREATE revolute joint module " + string(_module.id)); _module.joint = noone; }
                         else { if (_is_enemy) { /* Optional Success Debug */ } }
                    }
                } // End Module Joint Recreate
            } // End if scr_exists(_seg)
        } // End loop
         show_debug_message("    Finished recreating joints.");
    } // End if array exists

    show_debug_message("<<< scr_teleport_ship finished.");
}
