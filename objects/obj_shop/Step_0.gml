

	
/*
// How many items are left in the shop?
	// reset counter
number_of_items_left = 0
	// add up the items left that belong to the shop
for(var i = 0; i < number_of_items; i+=1;)
	if shop_segments[i].module != noone
		with(shop_segments[i].module)
			if owned_by_shop == true
				other.number_of_items_left += 1
	// if no more items are left to select, close the shop
if number_of_items_left <= (number_of_items - number_of_items_to_select)
	for(var i = 0; i < number_of_items; i+=1;)
		if shop_segments[i].module != noone{
			with(shop_segments[i].module)
				instance_destroy();
			shop_segments[i].module = noone
			}
			*/
//Sound
if !audio_is_playing(shop_noise)
	shop_noise = audio_play_sound_on(audio_emitter,snd_shop_background_hum,1,0.8)