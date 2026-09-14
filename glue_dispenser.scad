$fn = $preview ? 30 : 100;

include <roundedcube.scad>


module mounting_plate() {
	holes = [[0, 0], [-15, 0], [1, 25], [-44, 25]];
	spacer_height = 3.5;

	difference() {
		union() {
			translate([-52, -7, 0.1])
				roundedcubez([60, 40, 5], radius=10);
			// spacers
			for (p = holes)
				translate([p[0], p[1], -spacer_height])
					cylinder(h=spacer_height, d=13, center=false);
		}

		// Trough holes
		for (p = holes)
			translate([p[0], p[1], 0])
				cylinder(h=20, d=spacer_height, center=true);

		// Holes for metal standoffs
		for (p = [holes[0], holes[1]]) {
			translate([p[0], p[1], -spacer_height - 0.01])
				cylinder(h=4.5, d=5.5, center=false);
		}
	}
}

// projection()
	mounting_plate();
