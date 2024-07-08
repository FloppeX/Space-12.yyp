// Creates a sparkle on he object. Called from draw phase. Object must have timer
function scr_diamond_twinkle(argument0,argument1,argument2,argument3){
	var duration = argument0
	var interval = argument1
	var distance = argument2
	var temp_direction = argument3-phy_rotation
	var temp_timer = 0
	var scale = 0
	var rotation = 0
	if timer mod interval < duration {
		temp_timer = timer mod duration
		if temp_timer < (duration/2)
			scale = temp_timer/(duration/2)
		if temp_timer >= (duration/2)
			scale = (duration-temp_timer)/(duration/2)
		rotation = temp_timer * 8
		draw_sprite_ext(spr_star_twinkle,-1,phy_position_x+lengthdir_x(distance,temp_direction),phy_position_y+lengthdir_y(distance,temp_direction),scale*4,scale*4,rotation,c_white,0.9)
	}
	if timer mod interval == 0
		audio_play_sound_on(audio_emitter,snd_diamond_tinkle,0,1)
}