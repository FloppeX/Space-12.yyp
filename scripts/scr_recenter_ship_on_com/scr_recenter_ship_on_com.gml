/// @function scr_recenter_ship_on_com()
/// @description Calculates the center of mass (CoM) for the ship structure
///              (based ONLY on segments) and shifts ONLY the main body's origin
///              to align with the calculated CoM. Segments/modules are held relative by joints.
///              Assumes called from the main ship instance.
///              Requires ship_segment array and physics properties on segments.

function scr_recenter_ship_on_com() {

    show_debug_message("Running scr_recenter_ship_on_com for " + string(self.id) + " (Shift Main Body Only)");

    var total_mass = 0;
    var total_weighted_x = 0;
    var total_weighted_y = 0;

    // --- 1. Calculate Total Mass and Weighted Positions (Segments ONLY) ---
    if (variable_instance_exists(self.id, "ship_segment") && is_array(self.ship_segment)) {
        for (var i = 0; i < array_length(self.ship_segment); i += 1) {
            var _seg = self.ship_segment[i];
            if (scr_exists(_seg)) {
                if (_seg.phy_active && _seg.phy_mass > 0) {
                    total_mass += _seg.phy_mass;
                    total_weighted_x += _seg.phy_mass * _seg.phy_position_x;
                    total_weighted_y += _seg.phy_mass * _seg.phy_position_y;
                }
            }
        }
    } else {
        show_debug_message(" WARN: ship_segment array missing or invalid in scr_recenter_ship_on_com for " + string(self.id));
        exit;
    }

    // --- 2. Calculate Center of Mass (CoM) ---
    if (total_mass <= 0) {
        show_debug_message(" WARN: Total segment mass is zero or negative. Cannot calculate CoM. No shift applied.");
        exit;
    }

    var com_x = total_weighted_x / total_mass;
    var com_y = total_weighted_y / total_mass;

    show_debug_message("  Calculated CoM (Segments Only): (" + string(com_x) + ", " + string(com_y) + "), Current Origin: (" + string(self.phy_position_x) + ", " + string(self.phy_position_y) + ")");

    // --- 3. Calculate Offset ---
    var offset_x = com_x - self.phy_position_x;
    var offset_y = com_y - self.phy_position_y;

    show_debug_message("  Offset needed: (" + string(offset_x) + ", " + string(offset_y) + ")");

    // --- 4. Reposition ONLY the Main Body (if offset is significant) ---
    var threshold = 0.01;
    if (abs(offset_x) > threshold || abs(offset_y) > threshold) {

        show_debug_message("  Applying repositioning shift to main body ONLY...");

        // Shift the main ship body by the NEGATIVE offset
        self.phy_position_x -= offset_x;
        self.phy_position_y -= offset_y;

        // --- DO NOT SHIFT SEGMENTS OR MODULES HERE ---
        // They should follow due to the weld joints connecting them to 'self'

        show_debug_message("  Main body shift applied. New Origin: (" + string(self.phy_position_x) + ", " + string(self.phy_position_y) + ")");

    } else {
        show_debug_message("  Offset is negligible, no repositioning needed.");
    }

    show_debug_message("scr_recenter_ship_on_com finished for " + string(self.id));
}
