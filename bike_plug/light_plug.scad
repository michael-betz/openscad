$fn = $preview ? 30 : 100;

include <../roundedcube.scad>

difference() {
	roundedcubez(size=[30, 25, 12], center=true, radius=2);
	translate([0, 0, -11])
		rotate([90, 0, 0])
			cylinder(h=30, d=25, center=true);
	translate([9, 0, 0]) {
		cylinder(h=30, d=4, center=true);
		translate([0, 0, -14])
			cylinder(h=30, d=10, center=true);
	}
	for (i=[-1, 1])
		translate([0, 8 * i, -7.5])
			rotate([90, 0, 0])
				difference() {
					cylinder(h=4, d=50, center=true);
					cylinder(h=6, d=25, center=true);
				}
}

