$fn = $preview ? 30 : 150;

module main() {
	crt_hole_height = 16;
	d1= 23;
	d2 = 28;

	angle = 45;
	difference() {
		union() {
			// outer diameter
			cylinder(h=60, d1=d1, d2=d2, center=true);

			// flat area for CRT socket
			translate([7, 0, crt_hole_height])
				rotate([0, 90, 0])
					cylinder(h=14, d=27, center=true);

			// flat area for screws
			difference() {
				for (i=[-1, 1])
					translate([0, 0, crt_hole_height])
						rotate([angle, 0, 0])
							translate([7, i * 22/ 2, 0])
								rotate([0, 90, 20 * i])
									cylinder(h=30, d=10, center=true);

				// cut the front face
				translate([64, 0, 0])
					cube(size=[100, 100, 100], center=true);

			}
		}

		translate([0, 0, crt_hole_height])
			rotate([angle, 0, 0])
				for (i=[-1, 1])
					// screw holes
					translate([12, i * 28 / 2, 0]) {
						rotate([0, 90, 0])
							cylinder(h=20, d=3.5, center=true);
						// square nut slots
						translate([0, i * -2.5, 0])
							cube(size=[2, 10, 6], center=true);
					}


		// inner diameter
		translate([0, 0, -2])
			cylinder(h=60, d1=d1 - 4, d2=d2 - 4, center=true);

		// hole for CRT socket
		translate([10, 0, crt_hole_height])
			rotate([0, 90, 0])
				cylinder(h=20, d=22.5, center=true);
	}
}

intersection() {
	main();
	// translate([50, 0, 0])
	// 	cube(size=[100, 200, 100], center=true);
}

