event_inherited();

module_name = "Fusion reactor"

with(obj_player)
	if particles > 0.03 and energy < max_energy{
		particles -= 0.03
		energy_increase_multiplier += 0.3
	}