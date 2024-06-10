age += 1;

if obj_health <= 0
	{
	

	
	if child_object != noone{	
		travel_direction = point_direction(0, 0, phy_speed_x, phy_speed_y)
		new_asteroid_1 = instance_create_depth(phy_position_x,phy_position_y,0,child_object)
		new_asteroid_1.phy_speed_x = lengthdir_x(phy_speed+1,travel_direction+45)
		new_asteroid_1.phy_speed_y = lengthdir_y(phy_speed+1,travel_direction+45)
		new_asteroid_2 = instance_create_depth(phy_position_x,phy_position_y,0,child_object)
		new_asteroid_2.phy_speed_x = lengthdir_x(phy_speed+1,travel_direction-45)
		new_asteroid_2.phy_speed_y = lengthdir_y(phy_speed+1,travel_direction-45)
		}
	
	
	// Create credits after an enemy dies

	for(var i = 0; i < pickup_objects; i+=1;){
		var tempdir = random(360) //+ i * temp_angle_offset
		var tempdist = random(20) + 20
		pickup_object = instance_create_depth(phy_position_x,phy_position_y,-10,pickup_object_type);
		pickup_object.phy_position_x = phy_position_x+lengthdir_x(tempdist,tempdir)
		pickup_object.phy_position_y = phy_position_y+lengthdir_y(tempdist,tempdir)
		pickup_object.phy_speed_x = phy_speed_x
		pickup_object.phy_speed_y = phy_speed_y
		}
	scr_explosion_smoke_particles(6)
	
	instance_destroy();
	exit;
	}
	
if phy_speed > max_speed
	phy_linear_damping = 0.2
else 
	phy_linear_damping = 0
	
phy_angular_velocity = clamp(phy_angular_velocity,-max_rotation_speed,max_rotation_speed)

//Sound

audio_emitter_position(audio_emitter,phy_position_x,phy_position_y,0)
audio_emitter_velocity(audio_emitter, phy_speed_x, phy_speed_y, 0);

// Find mirror positions

scr_find_mirror_positions();

scr_wrap_room();

// Collisions! This code is needed so that the collision force can be found

collision_timer -= 1
if collision_timer == 0{
	phy_speed_x_previous = phy_speed_x
	phy_speed_y_previous = phy_speed_y
	}
	
var x_speed_diff = phy_speed_x_previous - phy_speed_x
var y_speed_diff = phy_speed_y_previous - phy_speed_y

collision_force = sqrt(sqr(x_speed_diff)+sqr(y_speed_diff))

if collision_force > 0 and collided == true and scr_exists(collision_victim){
var temp_damage = floor(collision_force * phy_mass * damage)+4
if temp_damage > max_damage
	temp_damage = max_damage
collision_victim.obj_health -= temp_damage
damage_number = instance_create_depth(collision_victim.phy_position_x,collision_victim.phy_position_y,-1,obj_damage_number)
damage_number.damage = temp_damage;
damage_number.color = c_yellow;

var temp_sound
switch (irandom(2)){
		case 0: temp_sound = snd_asteroid_smash_1; break;
		case 1: temp_sound = snd_asteroid_smash_2; break;
		case 2: temp_sound = snd_asteroid_smash_3; break;
		}
var temp_sound_gain = 0.5+2*temp_damage/30
audio_play_sound_on(audio_emitter,temp_sound,0,random(2),temp_sound_gain)

collided = false
collision_victim = noone
}