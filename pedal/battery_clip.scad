$fn = $preview ? 30 : 150;

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

// print with 110 % flow in an attempt to make it watertight
module end_clip_glue() {
	difference() {
		union() {
			h = 4;
			translate([0, 0, -h / 2])
				cylinder(h=h, d=22, center=true);

			// flange
			translate([0, 0, 1])
				cylinder(h=2, d=24, center=true);
		}
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

module pipe() {
	difference() {
		cylinder(h=600, d=25, center=true);
		cylinder(h=601, d=23, center=true);
	}
}

module o_ring_clip(with_spout=false) {

	difference() {
		// outer diameter
		h = 11;
		union() {
			if (with_spout)
				// spout
				translate([0, 0, 5])
					cylinder(h=10, d1=7.5, d2=6, center=true);

			// flange
			translate([0, 0, 0.5])
				cylinder(h=1, d=25, center=true);

			// outer diameter
			translate([0, 0, -h / 4])
				cylinder(h=h / 2, d=20.5, center=true);
		}

		// inner diameter
		// translate([0, 0, -10 - 1])
		// 	cylinder(h=20, d=17, center=true);

		// notch for o-ring
		for (i=[-1, -4])
			translate([0, 0, i])
				rotate_extrude()
					translate([9.9, 0, 0])
						circle(d=2.1);

		if (with_spout)
			// hole for spout
			cylinder(h=50, d=3, center=true);
	}
}

module main() {
	translate([0, 0, -300])
		pipe();
	// middle_clip();
	// end_clip_glue();
	// c_clip();
	o_ring_clip(true);
}

intersection() {
	main();
	translate([-50, 0, 0])
		cube(size=[100, 200, 100], center=true);
}
