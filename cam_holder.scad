$fn = $preview ? 30 : 150;

d_cam = 48.3;  // camera diameter (between 2 flat sides)
y_dist = 15;  // distance between cam and alu profile
t_wall = 5;  // wall thickness


module main() {
	difference() {
		union() {
			// outer diameter
			translate([0, 0, (41 - t_wall) / 2])
				cylinder(h=41 + t_wall, d=(d_cam + t_wall * 2) * 1.1547, center=true, $fn=6);

			// attachement cube
			t_cube = y_dist - t_wall;
			translate([0, -t_cube / 2 - d_cam / 2 - t_wall, (41 - t_wall) / 2])
				cube(size=[33.66, t_cube, 41 + t_wall], center=true);
		}
		// inner diameter
		translate([0, 0, 24])
			cylinder(h=48, d=d_cam * 1.1547, center=true, $fn=6);

		// hole for objective
		cylinder(h=100, d=31, center=true);

		for (z=[7, 33])
			translate([0, -30.15 + 5, z])
				rotate([90, 0, 0]) {
					cylinder(d=6.5, h=40, center=true);
					cylinder(d=13, h=18, center=true);
				}
	}
}

// hardware
module screw() {
	translate([0, 0, -4 + 13])
		cylinder(h=8, d=10, center=true);
	cylinder(h=22, d=6, center=true);
}

// translate([0, -39, 7])
// 	rotate([-90, 0, 0])
// 		screw();

intersection() {
	main();
	// translate([0, 0, -50 + 7])
	// 	cube(size=[100, 100, 100], center=true);
}
