var module_placement_ok = true

with(obj_player)
		for(var i = 0; i < array_length(ship_segment); i+=1;){
			if !scr_check_module_placement(ship_segment[i].module,ship_segment[i])
				module_placement_ok = false
		}

if activated 
	if module_placement_ok{
		global.player_exiting_shop = true
		global.player_entering_shop = false
		}
	else {
		audio_play_sound_on(obj_shop.shop_audio_emitter,snd_shop_error_1,0,1)
		activated = false
		show_module_placement = true
	}