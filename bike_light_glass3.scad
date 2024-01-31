$fn=100;
include <roundedcube.scad>

module blocks() {
	roundedcube(size=[25, 10, 56], center=true, radius=4);
	minkowski() {
		d_mink = 8;
		rotate([90, 0, 0])
			cylinder(d=d_mink);
		difference() {
			translate([0, 8, 0])
				cube(size=[75 - d_mink, 5, 70 - d_mink], center=true);
			// triangle shape
			for (s=[-1, 1])
				translate([s * (37 - d_mink), 8, 0])
					rotate([0, -s * 6.5, 0])
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
				translate([9 * s, 0, 22 * t])
					rotate([90, 0, 0])
						cylinder(h=30, d=1.75, center=true);
		}
		// notch for glass tube
		translate([0, -5, 0])
			cylinder(h=100, d=15.5, center=true);
		// zip tie holes
		for (s=[-1, 1])
			translate([7 * s, 5, -31])
				rotate([90, 0, 0])
					cylinder(h=20, d=4, center=true);
		translate([0, 5, 31])
			rotate([90, 0, 0])
				cylinder(h=20, d=4, center=true);
	}
}


intersection() {
	light();
	translate([0, 0, 0])
		cube([100, 100, 100], center=true);
}
