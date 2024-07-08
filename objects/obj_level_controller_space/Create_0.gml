// test

//instance_create_layer(0,0,layer_get_id("instance_layer"),obj_mouse_cursor)

// View settings

global.camera.phy_position_x = 0.5 * room_width
global.camera.phy_position_y = 0.5 * room_height

//global.zoom = 1100

// Clear particles

part_particles_clear(global.part_system_above)
part_particles_clear(global.part_system_below)

// Place player in the center of the room

if instance_exists(obj_player){
	global.player = instance_find(obj_player,0)
	global.player.controls_disabled_timer = 60
	global.player.phy_position_x = 0.5 * room_width
	global.player.phy_position_y = 0.5 * room_height
	global.player.phy_rotation = 0
	global.player.draw_scale = 0.01
	}
if !instance_exists(obj_player){
	global.player = instance_create_depth(0.5 * room_width,0.5 * room_height,-6,obj_player)
	global.player.controls_disabled_timer = 60
	global.player.phy_rotation = 0
	global.player.draw_scale = 0.01
	}
	
// Show map

obj_player.show_map = true;	

// Camera

global.camera.x = 3000
global.camera.y = 3000
global.camera.follow_object = obj_player
	
// Wormhole

wormhole = instance_create_depth(0.5 * room_width,0.5 * room_height,100,obj_wormhole_level_begin_player)
//global.camera.follow_object = wormhole

// timers
stage_timer_start = 7200
stage_timer = stage_timer_start

number_of_waves = 3
enemy_wave_timer = 360
ship_interval_timer_start = 60
ship_interval_timer = ship_interval_timer_start

death_timer = 120

next_level_timer = 120

end_wormhole_created = false
wormhole_end_timer = 1800
wormhole_end_gone = false

// Level

//level = 1

// Enemies

number_of_asteroids = 18
number_of_gold_asteroids = 2 + round(global.difficulty_level/3)
number_of_other_asteroids = 10 + 2* irandom(global.difficulty_level)//12 + irandom(4 * global.difficulty_level)
number_of_explosive_barrels = 2 + irandom(global.difficulty_level)
number_of_enemies = 0
number_of_diamonds = 2

	
// Sound

audio_stop_all()
level_music = music_funky_gameplay_looping
//if global.music_on 
	audio_play_sound(level_music,1,1)


// Create background sprites

scr_create_background_layers()

// Add enemies and asteroids if needed

for (var i = 0; i < number_of_asteroids;i+=1){
	if irandom(1) == 0{
		temp_xpos = global.wrap_border_left + random(global.play_area_width)//global.wrap_border_left + random(global.play_area_width)
		temp_ypos = global.wrap_border_top//global.wrap_border_top
		}
	else{
		temp_xpos = global.wrap_border_left
		temp_ypos = global.wrap_border_top + random(global.play_area_height)
		}
	instance_create_depth(temp_xpos,temp_ypos,0,obj_asteroid_big);
}

level_credit_pickups = 18
for(var i = 0; i<number_of_asteroids;i+=1)
	with (instance_find(obj_asteroid_big,i)){
		if pickup_object_type == noone{
			pickup_objects = irandom(6)+2
			pickup_objects = min(pickup_objects,other.level_credit_pickups)
			if pickup_objects > 0
				pickup_object_type = obj_pickup_credit
			other.level_credit_pickups -= pickup_objects
			}
	}
			
level_health_pickups = 12
for(var i = 0; i<number_of_asteroids;i+=1)
	with (instance_find(obj_asteroid_big,i)){
		if pickup_object_type == noone{
			pickup_objects = irandom(6)+2
			pickup_objects = min(pickup_objects,other.level_health_pickups)
			if pickup_objects > 0
				pickup_object_type = obj_pickup_health
			other.level_health_pickups -= pickup_objects
		}
	}
	
level_particle_pickups = 12
for(var i = 0; i<number_of_asteroids;i+=1)
	with (instance_find(obj_asteroid_big,i)){
		if pickup_object_type == noone{
			pickup_objects = irandom(6)+2
			pickup_objects = min(pickup_objects,other.level_particle_pickups)
			if pickup_objects > 0
				pickup_object_type = obj_pickup_particles
			other.level_particle_pickups -= pickup_objects
		}
	}
//create one asteroid with a diamond
repeat(number_of_diamonds)
	with (instance_find(obj_asteroid_big,irandom(number_of_asteroids-1))){
			diamonds += 1
			//obj_health = 2*obj_health
			}
/*
for (var i = 0; i < number_of_other_asteroids;i+=1){ //number_of_asteroids >= 1{
	if irandom(1) == 0{
		temp_xpos = global.wrap_border_left + random(global.play_area_width)//global.wrap_border_left + random(global.play_area_width)
		temp_ypos = global.wrap_border_top//global.wrap_border_top
		}
	else{
		temp_xpos = global.wrap_border_left
		temp_ypos = global.wrap_border_top + random(global.play_area_height)
		}
	var random_number = random(100)
	if random_number <= (global.asteroid_chance_credit + global.asteroid_chance_health)
		new_asteroid =  instance_create_depth(temp_xpos,temp_ypos,0,obj_asteroid_big_health);
		else {if random_number<= (global.asteroid_chance_credit + global.asteroid_chance_health + global.asteroid_chance_particles)
			new_asteroid =  instance_create_depth(temp_xpos,temp_ypos,0,obj_asteroid_big_particles);
			else new_asteroid =  instance_create_depth(temp_xpos,temp_ypos,0,obj_asteroid_big);
			}
		
	
	}
	
//create one asteroid with a diamond

with (instance_find(obj_asteroid_big,irandom(number_of_gold_asteroids))){
		diamonds = 5
		obj_health = 2*obj_health
		}