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
				translate([0, 0, -10.5])
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

			if (with_channel)
				translate([0, 0, -19])
					top_plate_chamfer(50, x=45, y=78);
	}
}

module board(){
	difference() {
		translate([0, -28 / 2, 0])
			cube(size=[33, 28, 3]);
		// Right long hole
		translate([32, 0, 0])
			cylinder(h=10, d=2.6, center=true);
		translate([32 + 2.6 / 2, 0, 0])
			cube([2.6, 2.6, 10], center=true);
		for (i=[-1, 1]) {
			// Top bottom hole
			translate([12, i * 28 / 2, 0])
				cylinder(h=10, d=2.6, center=true);
			// Poewr hole
			translate([32.2 - 1, i * 5, 0])
				cylinder(h=10, d=1.6, center=true);
		}
	}
	// USB
	color("blue")
		translate([-1, -9 / 2, 3])
			cube(size=[7.5, 9, 5 - 3]);
	// Btn
	color("white")
		translate([2.25, -14.5, 3])
			cube(size=[7, 2.5, 5.25 -3]);
	// L
	color("black")
		translate([17, -14, 3])
			cube(size=[10.5, 10.5, 5.5 -3]);
}

module board_stamp(){
	translate([0, 19, 0])
		cube_(size=[29, 33.5, 3.5]);

	translate([0, 1.5, 0])
		cube_(size=[20, 10, 4]);
	// USB
	translate([0, 32.7, -0.1])
		cube_([10, 9, 10]);
	// L
	translate([-8.7, 13.2, -0.1])
		cube_([12, 12, 10]);
	// Switch
	translate([-13.75, 29.8, 1.5])
		cube_([5, 8.5, 5]);
	// Switch hole
	translate([-25, 29.8, 4])
		rotate([0, 90, 0])
			cylinder(d=3, h=10);
	// LEDs
	translate([12.5, 30.5, -0.1])
		cube_([4, 10.5, 10]);
}

module top_plate_chamfer(angle=30, x=41, y=71) {
	for (i=[-1, 1])
		translate([i * x / 2, 0, 0])
			rotate([0, -i * angle, 0])
				cube(size=[20, 100, 20], center=true);

	for (j=[-1, 1])
		translate([0, j * y / 2, 0])
			rotate([j * angle, 0, 0])
				cube(size=[100, 20, 20], center=true);
}

module top_plate_b() {
	difference() {
		roundedcubez_([41, 71, 5.5], 7);
		translate([0, 0, -0.1])
			board_stamp();

		translate([0, 0, -9])
			top_plate_chamfer(40);

		// cable channel
		translate([0, 0, -0.1])
			cube_([6.4, 100, 3.5]);
	}
	// Pins
	translate([0, 3.3, 0])
		cylinder(h=5.5, d=2.3);
	for (i=[-1, 1])
		translate([i * 28.5 / 2, 23.5, 0])
			cylinder(h=5.5, d=2.3);
}

module shell() {
	h = 22;
	thck = 3;
	translate([0, 0, -h/2])
		difference() {
			roundedcubez_([42 + thck, 72 + thck, h + 4], 7);
			translate([0, 0, -1])
				roundedcubez_([42, 72, h + 10], 7);
			// Hole for USB-C
			translate([0, 41, 23.5])
				rotate([90, 0, 0])
					roundedcubez_(size=[10, 3, 10], radius=1);
			// Button
			translate([-25, 29.8, 23.65])
				rotate([0, 90, 0])
					cylinder(h=10, d=3);
		}
}

module pin() {
	cylinder(d=2.5, h=7.5);
	cylinder(d=3.5, h=1);
}

module all() {
	// batt();
	// batt_plate();
	mirror([0, 0, 1])
		batt_plate(true);

	// translate([0, 0, h_batt])
	// 	top_plate_b();

	// translate([0, 35.5, 9.4])
	// 	rotate([0, 0, -90])
	// 		board();

	// translate([0, 0, 0.75])
	// 	shell();
}

intersection() {
	all();
	// translate([83, 0, 0])
	// 	cube(size=[200, 200, 200], center=true);
}

// pin();
