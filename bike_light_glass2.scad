$fn=50;
include <roundedcube.scad>

module blocks() {
	roundedcube(size=[56, 15, 25], center=true, radius=4);
}

module light() {
	difference() {
		blocks();
		for (s=[-1, 1]) {
			// holes to attach glass tube
			for (t=[-1, 1])
				translate([18 * s, 0, 8.5 * t])
					rotate([90, 0, 0])
						cylinder(h=20, d=1.5, center=true);
			// zip tie notch
			translate([0, 12.5, s * 9])
				difference() {
					cylinder(h=5, d=32, center=true);
					cylinder(h=5.1, d=29, center=true);
				}
		}
		// notch for glass tube
		translate([0, -8, 0])
			rotate([0, 90, 0])
				cylinder(h=60, d=15.5, center=true);
		// notch for saddle pipe
		translate([0, 14, 0])
			cylinder(h=60, d=28, center=true);
	}
}


intersection() {
	light();
	translate([0, 0, 0])
		cube([100, 100, 100], center=true);
}
