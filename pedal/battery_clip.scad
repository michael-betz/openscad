$fn = $preview ? 30 : 100;

// d_out = 23;  // For Tomeks printer
d_out = 22.7;  // For my printer
batt_spacer = 3;

module middle_clip() {
	difference() {
		cylinder(h=25, d=d_out, center=true);

		// blind hole
		translate([0, 0, 10 + batt_spacer / 2])
			cylinder(h=20, d=19, center=true);
		translate([0, 0, -10 - batt_spacer / 2])
			cylinder(h=20, d=19, center=true);

		// through hole
		cylinder(h=40, d=15, center=true);

		// cut in two
		translate([10, 0, 0])
			cube(size=[20, 9, 50], center=true);

		// notch for easier bending / cable routing
		for (angle=[0:45:361])
			rotate([0, 0, angle])
				translate([-8.1, 0, 0])
					cylinder(d=5, h=50, center=true);

	}
}


module end_clip() {
	difference() {
		translate([0, 0, -25 / 4])
			cylinder(h=25 / 2, d=d_out, center=true);

		// blind hole
		translate([0, 0, -10 - 1])
			cylinder(h=20, d=19, center=true);

		// cut in two
		translate([15, 0, 0])
			cube(size=[20, 9, 50], center=true);

		// notch for easier bending / cable routing
		translate([-14.8, 0, 0])
			cube(size=[10, 5, 50], center=true);

	}
}

module c_clip() {
	difference() {
		cylinder(h=batt_spacer, d=18, center=true);

		// through hole
		cylinder(h=40, d=15, center=true);

		// cut in two
		translate([10, 0, 0])
			cube(size=[20, 9, 50], center=true);
	}
}

// middle_clip();
// end_clip();
c_clip();

