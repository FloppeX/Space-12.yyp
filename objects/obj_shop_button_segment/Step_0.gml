
if activated and !button_used{
	if obj_player.credits >= credit_cost{
		with(global.player)
			scr_add_ship_segment(id,24,obj_ship_segment_player)
		obj_player.credits -= credit_cost
		button_used = true
		}
	activated = false
	}
	
