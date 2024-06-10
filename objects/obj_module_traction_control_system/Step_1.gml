event_inherited();

will_affect_neighbor = false

if scr_module_is_neighbor(obj_module_cockpit,id){
	will_affect_neighbor = true
	owner.drift_resistance_bonus += 50
}