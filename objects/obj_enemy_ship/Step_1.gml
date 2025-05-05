// At VERY START of obj_enemy_ship Step_0 Event

// Check if the 'just_wrapped' variable was set by the wrap script
// (We need to add setting this flag in the wrap script)
if (variable_instance_exists(id, "just_wrapped") && just_wrapped == true) {
    show_debug_message("ENEMY WRAP FRAME: ID=" + string(id) + " Vel=(" + string(phy_speed_x) + "," + string(phy_speed_y) + ") AngVel=" + string(phy_angular_velocity));
    just_wrapped = false; // Reset the flag
} else if (phy_speed > 15) { // Log if speed is unusually high ANY time
     if (timer mod 15 == 0) { // Throttle logging
          show_debug_message("ENEMY HIGH SPEED: ID=" + string(id) + " Vel=(" + string(phy_speed_x) + "," + string(phy_speed_y) + ") Speed=" + string(phy_speed));
     }
}


// Find mirror positions

scr_find_mirror_positions();
