function scr_add_random_modifier_new() {
	var i = irandom(9)
		switch (i){
			case 0: scr_add_modifier_new(scr_module_modifier_dum_dum_bullets,0,"Dum-Dum bullets",noone,noone); break;
			case 1: scr_add_modifier_new(scr_module_modifier_double_barrel,0,"Double barrel",noone,noone); break;
			case 2: scr_add_modifier_new(scr_module_modifier_teflon_coated_barrel,0,"Teflon coated barrel",noone,noone); break;
			case 3: scr_add_modifier_new(scr_module_modifier_graphite_receiver,0,"Graphite receiver",noone,noone); break;
			case 4: scr_add_modifier_new(scr_module_modifier_high_speed_flanges,8,"High speed flanges",noone,noone); break;
			case 5: scr_add_modifier_new(scr_module_modifier_steel_cut_barrel,0,"Steel-cut barrel",noone,noone); break;
			case 6: scr_add_modifier_new(scr_module_modifier_triple_barrel,8,"Triple barrel",noone,noone); break;
			case 7: scr_add_modifier_new(scr_module_modifier_heavy_duty_receiver,0,"Heavy-duty receiver",noone,noone); break;
			case 8: scr_add_modifier_new(scr_module_modifier_bump_stock,0,"Bump stock",noone,noone); break;
			case 9: scr_add_modifier_new(scr_module_modifier_titanium_firing_pin,0,"Titanium firing pin",noone,noone); break;
			case 10: scr_add_modifier_new(scr_module_modifier_braided_copper_cables,0,"Braided copper cables",noone,noone); break;
			case 11: scr_add_modifier_new(scr_module_modifier_heavy_bolt,0,"Heavy bolt",noone,noone); break;
			}
}
