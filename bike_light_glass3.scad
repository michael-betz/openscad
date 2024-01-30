$fn=20;
include <roundedcube.scad>

module blocks() {
	roundedcube(size=[25, 10, 56], center=true, radius=4);
	minkowski() {
		d_mink = 8;
		rotate([90, 0, 0])
			cylinder(d=d_mink);
		difference() {
			translate([0, -1.5 + 5, 0])
				cube(size=[75 - d_mink, 3, 70 - d_mink], center=true);
			// triangle shape
			for (s=[-1, 1])
				translate([s * (50 - d_mink), 0, 0])
					rotate([0, -s * 10, 0])
						cube(size=[50, 15, 150], center=true);
		}
	}
}

module light() {
	difference() {
		blocks();
		for (s=[-1, 1]) {
			// holes to attach glass tube
			for (t=[-1, 1])
				translate([8.5 * s, 0, 18 * t])
					rotate([90, 0, 0])
						cylinder(h=20, d=1.5, center=true);
		}
		// notch for glass tube
		translate([0, -5, 0])
			cylinder(h=100, d=15.5, center=true);
	}
}


intersection() {
	light();
	translate([0, 0, 0])
		cube([100, 100, 100], center=true);
}
