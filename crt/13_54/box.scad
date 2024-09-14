$fn = $preview ? 30 : 100;

crt_angle = 10;

plate_l = 500;
plate_x = -95;
plate_width = 100;
screw_width = 80;

pcb_x = -130;

include <crt.scad>
include <../../roundedcube.scad>
include <../../ali_parts.scad>
include <../crt_lib.scad>

module pos_crt(s=1.0) {
	translate([-10, 0, 100])
		rotate([180, 90 - crt_angle, 0])
			scale([s, s, 1])
				crt();
}

h = 90;
z = 2.5 + h / 2;

module tube_holder_base(x_pos=0) {
	difference() {
		translate([x_pos, 0, z])
			roundedcubez(size=[70, 100, h], center=true, radius=15);
		pos_crt(1.05);
	}
}

module tube_holder_mid(x_pos=0) {
	difference() {
		tube_holder_base(x_pos);

		// slot for velcro strap
		translate([0, 0, 95])
			scale([1, 0.85, 1.2])
				rotate([90, 0, 90])
					difference() {
						cylinder(h=20, d=120, center=true);
						cylinder(h=21, d=120 - 7, center=true);
					}

		for (i=[-1,1]) {
			translate([0, 40 * i, h + 5])
				cylinder(h=35, d=9, center=true);  //, $fn=6);
			translate([0, 40 * i, 10])
				cylinder(h=30, d=5.25, center=true);
		}

		// Bottom square nuts
		translate([0, 0, 8])
			cube(size=[8.5, 90, 3], center=true);

		// bridge cut-out
		roundedcube(size=[100, 60, 62], center=true, radius=15);
	}
	// screws
	// #translate([x_pos, -40, -2])
	// 	bolt_m5_16_cs(true);
}

module tube_holder_back(x_pos=0, is_top=1) {
	difference() {
		tube_holder_base(x_pos);

		translate([x_pos, 0, 0]) {
			translate([0, 0, z - h/4 + (is_top ? 0 : h/2)])
				cube(size=[150, 150, h / 2], center=true);
			difference() {
				// inner hollow pocket
				translate([-5, 0, h / 2 - 2])
					roundedcubez(size=[50, 100 - 5, h], center=true, radius=15);
				// little ears to put 2 square nuts
				for (i=[-1,1])
					translate([-21, i * 40, 4])
						difference() {
							translate([-8, i * 8, 0])
								roundedcubez(size=[30, 30, 10], center=true, radius=5);
							cylinder(h=20, d=5.25, center=true);
							translate([0, 0, 4])
								rotate([0, 0, 45])
									cube(size=[8.5, 8.5, 3], center=true);
						}
			}

			for (i=[-1, 1]) {
				// screw holes
				translate([27, 40 * i, h / 2])
					cylinder(h=h + 10, d=5.25, center=true);

				// bigger holes on top
				translate([27, 40 * i, 40 / 2 + 10 + z])
					cylinder(h=40, d=9, center=true);

				// square nut slot
				for (zp=[10, h / 2])
					translate([21, 40 * i, zp])
						cube(size=[20, 8.5, 3], center=true);
			}

			translate([27, 0, -20])
				roundedcube(size=[50, 60, 62], center=true, radius=15);
		}
	}
	// screws
	// translate([x_pos - 21, -40, -2])
	// 	bolt_m5_16_cs(true);
	// #translate([x_pos + 27.0, -40, -2])
	// 	bolt_m5_16_cs(true);
	// translate([x_pos + 27.0, -40, 58])
	// 	bolt_m5_20_hx(false);
}

module main() {
	color("white")
		pos_crt();
	tube_holder_back(-310, 1);
	tube_holder_back(-310, 0);
	tube_holder_mid();

	crt_plate(true);

	translate([pcb_x, 0, 0])
		crt_pcb();

	// include <socket_b12_37.scad>
	// translate([-313.5, 0, 46.5])
	// 	rotate([0, -crt_angle, 0])
	// 		rotate([0, 90, 0])
	// 			socket();
}


intersection() {
	main();
	translate([0, 110, 0])
		cube([1000, 300, 500], center=true);
}

// projection()
// 	plate();

