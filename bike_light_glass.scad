$fn=50;
include <roundedcube.scad>

module blocks() {
	translate([0, 0, 3.5])
		cube(size=[56, 15, 6], center=true);
	translate([0, 0, -25/2])
		cube(size=[56, 15, 25], center=true);
}

difference() {
	blocks();
	for (s=[-1, 1])
		translate([s * (36 + 7) / 2, 0, 0])
			rotate([90, 0, 0])
				cylinder(h=20, d=7, center=true);
	translate([0, -7.5, -14])
		rotate([0, 90, 0])
			cylinder(h=60, d=15, center=true);

	offs = 3;
	for (s=[-1, 1]) {
		translate([s * 10, offs, -10])
			rotate([0, 0, 0])
				cylinder(h=40, d=4.5, center=true);
		translate([s * 10, offs, 7])
			rotate([0, 0, 0])
				cylinder(h=6, d=8.2, center=true, $fn=6);
	}
	translate([0, 9, -25])
		roundedcubez(size=[35, 25, 6], radius=8, center=true);
}


