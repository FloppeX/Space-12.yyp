
// Debug message to confirm this event runs
if scr_timer(60) { // Print once per second
    show_debug_message("obj_com_marker Draw: ID=" + string(id) + " Pos=(" + string(floor(x)) + "," + string(floor(y)) + ") Visible=" + string(visible) + " Depth=" + string(depth));
}

// Draw the object's assigned sprite
if (visible) { // Only draw if visible
    draw_self();
}