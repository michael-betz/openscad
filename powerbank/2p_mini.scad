$fn = $preview ? 30 : 150;

include <../roundedcube.scad>

h_batt = 9.5;

module batt(d=18.5) {
	rotate([90, 0, 0])
		for (i=[-1, 1])
			translate([9.5 * i, 0, 0])
				cylinder(h=65.5, d=d, center=true);
}



module batt_plate(with_channel=false) {
	difference() {
		translate([0, 0, -h_batt])
			roundedcubez_([41, 71, h_batt], 7);
			batt(19);
			// cut sharp peak between the batts
			cube(size=[5, 100, 5], center=true);
			// cable channel
			if (with_channel)
				translate([0, 0, -11])
					rotate([90, 0, 0])
						cylinder(h=75, d=7, center=true);
			for (i=[-1, 1]) {
				//  cut-out for nickel strips
				translate([0, i * 36, 0])
					cube(size=[30, 10, 15], center=true);
				// cable holes
				if (with_channel)
					translate([0, i * 35, -15])
						cube_([7, 8, 20]);
			}
	}
}

module board_stamp(){
	translate([0, 19, 0])
		cube_(size=[29, 33.5, 5]);
	translate([0, 10, 0])
		cube_(size=[20, 30, 5]);
}

module top_plate_b() {
	difference() {
		roundedcubez_([41, 71, 5], 7);
		translate([0, 0, -0.1])
			board_stamp();
		// cable channel
		translate([0, 0, -0.1])
			cube_([6.4, 100, 3.5]);
	}
}

module shell() {
	h = 22;
	translate([0, 0, -h/2])
		difference() {
			roundedcubez_([44, 74, h + 4], 7);
			translate([0, 0, -1])
				roundedcubez_([42, 72, h + 10], 7);
			// Hole for USB-C
			translate([0, 41, 22.5])
				rotate([90, 0, 0])
					roundedcubez_(size=[10, 3, 10], radius=1);
		}
}

module all() {
	batt();
	batt_plate();
	mirror([0, 0, 1])
		batt_plate(true);

	translate([0, 0, h_batt])
		top_plate_b();

	translate([0, 0, 0.75])
		shell();
}

intersection() {
	all();
	// translate([100, 0, 0])
	// 	cube(size=[200, 200, 200], center=true);
}
