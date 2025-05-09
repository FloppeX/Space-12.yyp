// Physics settings

game_set_speed(60,gamespeed_fps)
physics_world_update_speed(60);
physics_world_update_iterations(20);


//

global.player_entering_shop = false
global.player_in_shop = false
global.player_exiting_shop = false

// Clear particles

part_particles_clear(global.part_system_above)
part_particles_clear(global.part_system_below)

// TEST prefetching sprites

//texturegroup_load(texgroup_shop)

// Zoom

global.zoom = 900

// Place player in the center of the room


if instance_exists(obj_player){
	global.player = instance_find(obj_player,0)
	global.player.disabled_timer = 60
	global.player.phy_position_x = 0.5 * room_width
	global.player.phy_position_y = 0.5 * room_height + 500
	//global.player.phy_rotation = 0
	global.player.draw_scale = 0.01
	}
if !instance_exists(obj_player){
	global.player = instance_create_depth(0.5 * room_width,0.5 * room_height + 500,-6,obj_player)
	global.player.disabled_timer = 60
	global.player.phy_rotation = 0
	global.player.draw_scale = 0.01
	}

// Move the camra to the player

with(obj_camera){
	phy_position_x = 0.5 * room_width
	phy_position_y = 0.5 * room_height+500
}

death_timer = 120
next_level_timer = 120

// Disable map
obj_player.show_map = false;

// Shop

shop = instance_create_depth(0.5 * room_width,0.5 * room_height,-4,obj_shop)
cursor = noone//instance_create_depth(0.5 * room_width,0.5 * room_height,30,obj_cursor_new)

// Wormhole

wormhole_begin = instance_create_depth(0.5 * room_width,0.5 * room_height+500,100,obj_wormhole_level_begin_player)

// Sound

audio_stop_all()

level_music = snd_music_shop
if global.music_on 
	audio_play_sound(level_music,1,1)


// Create background sprites

scr_create_background_layers()
