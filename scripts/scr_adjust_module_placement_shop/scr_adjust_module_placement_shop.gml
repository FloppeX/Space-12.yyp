function scr_adjust_module_placement_shop(argument0,argument1){

var module = argument0
var segment = argument1

repeat(40){
			if module.phy_com_x > segment.phy_position_x
				module.phy_position_x -= 1
			if module.phy_com_x < segment.phy_position_x
				module.phy_position_x += 1
			if module.phy_com_y > segment.phy_position_y
				module.phy_position_y -= 1
			if module.phy_com_y < segment.phy_position_y
				module.phy_position_y += 1
		}
}