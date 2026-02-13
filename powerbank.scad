$fn=50;

w_batt = 57;
h_batt = 85;
t_batt = 19;

t_wall = 1.6;

module box() {
	difference() {
		cube(size=[w_batt + 2 * t_wall, h_batt + 2 * t_wall, t_batt + 2 * t_wall], center=true);
		translate([0, 0, 2.5])
			cube(size=[w_batt, h_batt, t_batt + 5], center=true);
		translate([0, 5, (t_batt + t_wall + 0.01) / 2])
			cube(size=[w_batt + t_wall, h_batt + t_wall + 10, t_wall], center=true);
		translate([-w_batt / 2 + 6, -h_batt / 2, 0])
			cube([11, 10, t_batt], center=true);
	}
}

box();

translate([0, t_wall / 4, 18])
	cube(size=[w_batt + t_wall - 0.5, h_batt + 1.5 * t_wall - 0.1, t_wall], center=true);

intersection() {
	box();
	translate([50, 0, 0])
		cube([100, 100, 100], center=true);
}
