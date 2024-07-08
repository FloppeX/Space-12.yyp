if activated{
	if obj_player.credits >= credit_cost{
		with(global.player)
			obj_health += 20
		obj_player.credits -= credit_cost
		}
	activated = false
	}