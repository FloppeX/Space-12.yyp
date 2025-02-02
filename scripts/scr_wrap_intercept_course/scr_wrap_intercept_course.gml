/// intercept_course(origin,target,speed)
function scr_wrap_intercept_course(argument0, argument1, argument2) {
	//
	//  Returns the course direction required to hit a moving target
	//  at a given projectile speed, or (-1) if no solution is found.
	//
	//      origin      instance with position (x,y), real
	//      target      instance with position (x,y) and (speed), real
	//      speed       speed of the projectile, real
	//
	/// GMLscripts.com/license
	{
	    var origin,target,target_x,target_y,target_travel_dir,pspeed,dir,alpha,phi,beta;
	    origin = argument0;
	    target = argument1;
	    pspeed = argument2;
		target_x = scr_wrap_closest_x(target);
		target_y = scr_wrap_closest_y(target);
	    dir = point_direction(origin.phy_position_x,origin.phy_position_y,target_x,target_y);
		pspeed = pspeed+origin.phy_speed
	    alpha = target.phy_speed / pspeed;
		target_travel_dir = point_direction(0,0,target.phy_speed_x,target.phy_speed_y) //scr_wrap_direction_to_point(target.phy_position_xprevious,target.phy_position_yprevious,target.phy_position_x,target.phy_position_y)
	    phi = degtorad(target_travel_dir - dir);
	    beta = alpha * sin(phi);
	    if (abs(beta) >= 1)
	        return (-1);
	    dir += radtodeg(arcsin(beta));
		dir += 360
		dir = dir mod 360
	    return dir;
	}


}
