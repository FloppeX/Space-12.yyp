/// intercept_course(origin,target,speed)
// instance_x, instance_y: coordinates of the shooter
// instance_speed, instance_direction: speed and direction of the shooter
// target_x, target_y: coordinates of the target
// target_speed, target_direction: speed and direction of the target
// bullet_speed: speed of the bullet

// OBS does not wrap (yet)
function scr_wrap_intercept_course_new(shooter,target,bullet_speed){
	
if !scr_exists(shooter) or !scr_exists(target)
	return -1

var instance_x = shooter.phy_position_x
var instance_y = shooter.phy_position_y
var instance_speed = shooter.phy_speed
var instance_direction = -shooter.phy_rotation
var target_x = target.phy_position_x
var target_y = target.phy_position_y
var target_speed = target.phy_speed
var target_direction = -target.phy_rotation

    // Convert directions from degrees to radians
    var instance_dir_rad = degtorad(instance_direction);
    var target_dir_rad = degtorad(target_direction);

    // Calculate velocity components of the shooter
    var shooter_vx = instance_speed * cos(instance_dir_rad);
    var shooter_vy = instance_speed * sin(instance_dir_rad);

    // Calculate velocity components of the target
    var target_vx = target_speed * cos(target_dir_rad);
    var target_vy = target_speed * sin(target_dir_rad);

    // Relative position of the target to the shooter
    var dx = target_x - instance_x;
    var dy = target_y - instance_y;

    // Velocity of the bullet relative to the shooter
    var relative_bullet_speed_x = bullet_speed * cos(instance_dir_rad);
    var relative_bullet_speed_y = bullet_speed * sin(instance_dir_rad);

    // Effective bullet speed considering the shooter's movement
    var effective_bullet_vx = shooter_vx + relative_bullet_speed_x;
    var effective_bullet_vy = shooter_vy + relative_bullet_speed_y;

    // Relative velocity of the target to the shooter
    var relative_vx = target_vx - effective_bullet_vx;
    var relative_vy = target_vy - effective_bullet_vy;

    // Quadratic equation components to solve for t (time of interception)
    var a = sqr(relative_vx) + sqr(relative_vy) - sqr(bullet_speed);
    var b = 2 * (dx * relative_vx + dy * relative_vy);
    var c = sqr(dx) + sqr(dy);

    // Discriminant of the quadratic equation
    var discriminant = sqr(b) - 4 * a * c;

    if (discriminant < 0) {
		// No real solution means no valid angle to intercept
		return -1; // Return -1 to indicate no valid angle
    }



    // Calculate the two possible solutions for t
    var t1 = (-b + sqrt(discriminant)) / (2 * a);
    var t2 = (-b - sqrt(discriminant)) / (2 * a);


    // We need the smallest positive t
    var t;
    if (t1 > 0 && t2 > 0) {
        t = min(t1, t2);
    } else if (t1 > 0) {
        t = t1;
    } else if (t2 > 0) {
        t = t2;
    } else {
        return -1; // No valid time means no valid angle
    }

    // Calculate the future position of the target
    var future_x = target_x + target_vx * t;
    var future_y = target_y + target_vy * t;

    // Calculate the angle to shoot the bullet
    var angle_to_target = point_direction(instance_x, instance_y, future_x, future_y);

    return angle_to_target;
}