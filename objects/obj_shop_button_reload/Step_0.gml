	
if activated{
	if obj_player.credits >= credit_cost{
		with(global.player)
			particles += 20
		obj_player.credits -= credit_cost
		}
	activated = false
	}