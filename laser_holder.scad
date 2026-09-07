$fn = $preview ? 30 : 100;
include <roundedcube.scad>

module laser() {
	translate([0, 0, 27]) {
		rotate([0, 90, 0]) {
			cylinder(h=20, d=12, center=true);
			ring(14);
		}
	}
}

module ring(d=10) {
	difference() {
		cylinder(h=5, d=d + 3, center=true);
		cylinder(h=6, d=d, center=true);
	}
}

module holder() {
	difference() {
		roundedcubez_(size=[15, 40, 27], 5);
		translate([0, 4, 0])
			laser();
		for (i=[-1, 1]) {
			translate([0, i * 10, 0])
				cylinder(h=30, d=3.5, center=true);
			translate([0, i * 18, 4])
				cube(size=[6, 25, 2], center=true);
		}
	}
}

intersection() {
	holder();
	// translate([-50, 0, 0])
	// 	cube(size=[100, 100, 100], center=true);
}
