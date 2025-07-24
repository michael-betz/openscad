$fn = $preview ? 30 : 100;

include <../roundedcube.scad>

difference() {
	translate([-5, 0, 0])
		roundedcubez(size=[75, 60, 15], center=true, radius=5);
	translate([-17.5 - 8, 0, -27.5 + 5])
		cube(size=[100, 40, 40], center=true);
	translate([-17.5 - 8, 0, 0])
		cube(size=[100, 53, 5.1], center=true);
	for (i=[-1, 1])
		translate([30, 9 * i, -1])
			rotate([0, 90, 0])
				cylinder(h=20, d=7, center=true);

	// Slot for clip
	translate([29.5 - 59, 0, 5])
		cube(size=[10, 25, 10], center=true);

	// bottom cut
	translate([19.5 - 50 - 45, 0, -7.5])
		cube(size=[10 + 100, 100, 20], center=true);
}
