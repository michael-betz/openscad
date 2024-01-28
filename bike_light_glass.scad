$fn=50;
include <roundedcube.scad>

module blocks() {
	translate([0, 0, 3.5])
		roundedcube(size=[56, 15, 6], center=true, radius=3);
	translate([0, 0, -25/2])
		roundedcube(size=[56, 15, 25], center=true, radius=3);
}

difference() {
	blocks();
	for (s=[-1, 1])
	for (s=[-1, 1]) {
		// clamping holes to attach to saddle rods
		translate([s * (36 + 7) / 2, 0, 0])
			rotate([90, 0, 0])
				cylinder(h=20, d=7, center=true);
		offs = 3;
		// Screw holes
		translate([s * 10, offs, -10])
			rotate([0, 0, 0])
				cylinder(h=40, d=4.5, center=true);
		// hexagonal holes for the 2 threaded nuts
		translate([s * 10, offs, 7])
			rotate([0, 0, 0])
				cylinder(h=6, d=8.2, center=true, $fn=6);
		// holes to attach glass tube
		for (t=[-1, 1])
			translate([15 * s, 0, -14 + 8.5 * t])
				rotate([90, 0, 0])
				cylinder(h=20, d=1.5, center=true);
	}
	// notch for glass tube
	translate([0, -7.5, -14])
		rotate([0, 90, 0])
			cylinder(h=60, d=15, center=true);
	// cut-away for hiding screw heads
	translate([0, 9, -24])
		roundedcubez(size=[35, 25, 6], radius=8, center=true);
}


