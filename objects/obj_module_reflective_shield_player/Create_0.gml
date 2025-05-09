event_inherited();

description_lines[0] = "Reflector shield"
shield_health = 15
recharge_each_step = 0.2
recharge_delay = 240
recharge_timer = recharge_delay

shield_object = obj_reflective_shield_player

my_shield = instance_create_depth(phy_position_x,phy_position_y,-9,shield_object);
my_shield.obj_health = shield_health
my_shield.owner = id

shield_particle = part_type_create();
part_type_sprite(shield_particle,spr_shield_new,0,0,0);
part_type_size(shield_particle,1,1,0,0.1);
part_type_scale(shield_particle,1,1);
part_type_color3(shield_particle,c_white,c_fuchsia,c_black);
part_type_alpha3(shield_particle,0.03,0.05,0);
part_type_speed(shield_particle,0,0,0,0);
part_type_direction(shield_particle,0,359,0,0);
part_type_orientation(shield_particle,0,0,0,1,1);
part_type_blend(shield_particle,1);
part_type_life(shield_particle,4,6);