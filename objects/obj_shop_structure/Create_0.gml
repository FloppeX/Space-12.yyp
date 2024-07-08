owner = instance_find(obj_shop,0)
sprite_index = spr_shop_structure_a;

var i = irandom(4)
	switch (i){
		case 0: sprite_index = spr_shop_structure_a; break;
		case 1: sprite_index = spr_shop_structure_b; break;
		case 2: sprite_index = spr_shop_structure_c; break;
		case 3: sprite_index = spr_shop_structure_d; break;
		case 4: sprite_index = spr_shop_structure_e; break;
		}
		
scale = 0.8+random(0.4)
depth = irandom(24)

phy_position_x += irandom(6)*10-30
phy_position_y += irandom(6)*10-30

color = make_color_hsv(owner.hue+irandom(40)-20,192,192)
shadow = true
/*
number_of_bits = 2
space_station_bits[0,0] = 0
for(var i = 0; i < number_of_bits+1; i++)
     for(var j = 0; j < 4; j++)
          space_station_bits[i, j] = 0;
 


for(var i = 0; i < number_of_bits; i+=1;){
	var i = irandom(3)
	switch (i){
		case 0: space_station_bits[i,0] = spr_shop_bits_a; break;
		case 1: space_station_bits[i,0] = spr_shop_bits_b; break;
		case 2: space_station_bits[i,0] = spr_shop_bits_c; break;
		case 3: space_station_bits[i,0] = spr_shop_bits_d; break;
		}
	var temp_width = 0.6 * sprite_width
	var temp_height = 0.6 * sprite_height
	space_station_bits[i,1] = irandom(temp_width)-temp_width/2
	space_station_bits[i,2] = irandom(temp_height)-temp_height/2
}
	

