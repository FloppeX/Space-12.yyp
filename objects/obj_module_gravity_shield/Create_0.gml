event_inherited();

description_lines[0] = "Gravity shield"
description_lines[1] = "Active device"
description_lines[2] = "Pushes objects away"


depth = -12

active = true 

activation_button = 0
activated = false

// Animation

ready_to_go = false
casing_retracted = true
casing_extended = false

//

energy_cost = 1.5

activate_shield = false;
shield_active = false
shield_max_size = 2.3
shield_current_size = 0
size_change_coefficient = 15
gravity_radius = 200
gravity_force = 5
global.force_x = 0
global.force_y = 0

/*
shield = physics_fixture_create()
physics_fixture_set_circle_shape(shield, 200)
physics_fixture_set_awake(shield, true)
physics_fixture_set_sensor(shield, true)
physics_mass_properties(0, phy_com_x, phy_com_y, 0)
*/

shield_particle = part_type_create();
part_type_shape(shield_particle,pt_shape_circle);
part_type_size(shield_particle,0,3,0,0.1);
part_type_scale(shield_particle,3,3);
part_type_color3(shield_particle,c_white,c_navy,c_black);
part_type_alpha3(shield_particle,0.05,0.07,0);
part_type_speed(shield_particle,0,0,0,0);
part_type_direction(shield_particle,0,359,0,0);
part_type_orientation(shield_particle,0,0,0,1,1);
part_type_blend(shield_particle,1);
part_type_life(shield_particle,4,6);