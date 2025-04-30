$fn = $preview ? 30 : 100;

use <ali_parts.scad>;


h_clamp = 17;

module base() {
	difference() {
		translate([0, 0, 25 / 2])
			cube(size=[90, 90, 25], center=true);
		for (i=[-1, 1])
			for (j=[-1, 1])
				translate([77 / 2 * i, 77 / 2 * j, 0])
					cylinder(h=55, d=4.5, center=true);
		translate([0, 0, -10 + h_clamp])
			cube(size=[91, 55, 20], center=true);
	}
}


module notch() {
	translate([0, 0, 2.5])
		cube(size=[100, 7.5, 5], center=true);
	for (i=[-1, 1])
		translate([11.5 * i, 0, 2 + 5])
			cylinder(h=4, d=3, center=true);
}


module block() {
	difference() {
		base();
		translate([0, 0, h_clamp - 0.1])
			notch();
		translate([0, 0, h_clamp + 9])
			cube(size=[100, 55, 20], center=true);
		translate([0, 30, 10])
			cube([100, 50, 50], center=true);

		// cutout for bridge
		translate([0, 0, 4 + h_clamp])
			cube(size=[100, 100, 9], center=true);

		// Square nuts
		for (i=[-1, 1])
			translate([i * 20 / 2, -65 / 2, 8]) {
				cube(size=[8.5, 11, 3], center=true);
				cylinder(h=50, d=5.5, center=true);
			}
	}
}


module bridge() {
	difference() {
		translate([0, 0, 4])
			cube(size=[35, 75, 8], center=true);
		translate([0, 0, - 0.1])
			notch();
		for (i=[-1, 1])
			for (j=[-1, 1])
				translate([i * 20 / 2, j * 65 / 2, 8])
					cylinder(d=5.5, h=20, center=true);
	}
}


// block();
// mirror([0, 1, 0])
// 	block();

// translate([0, 0, h_clamp])
	bridge();

