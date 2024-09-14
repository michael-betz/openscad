$fn = $preview ? 30 : 100;

include <b10s3.scad>
include <../../roundedcube.scad>
include <../../ali_parts.scad>
include <../crt_lib.scad>

crt_angle = 17;

plate_l=300;
plate_x=0;
plate_width = 100;
screw_width = 80;

pcb_x = 6.7;

module pos_crt(s=1.0) {
	translate([8, 0, 71])
		rotate([0, -crt_angle, 0])
			scale(s)
				crt();
}

h = 93;
z = 2.5 + h / 2;

module tube_holder_base() {
	difference() {
		translate([0, 0, z])
			roundedcubez(size=[60, 100, h], center=true, radius=15);
		pos_crt(1.075);
	}
}

module tube_holder(is_top=false) {
	intersection() {
		tube_holder_base();
		rotate([0, -15, 0])
			translate([15, 0, 18 + (is_top ? 92 : 0)])
				cube(size=[100, 110, 90], center=true);
	}
}

module tube_holder_all() {
	difference() {
		tube_holder_base();
		for (i=[-1,1]) {
			translate([0, 40 * i, h + 5])
				cylinder(h=35, d=9, center=true);  //, $fn=6);
			translate([0, 40 * i, 50])
				cylinder(h=150, d=5.25, center=true);
		}
		// Top square nuts
		translate([0, 0, 60])
			cube(size=[8.5, 90, 3], center=true);

		// Bottom square nuts
		translate([0, 0, 10])
			cube(size=[8.5, 90, 3], center=true);

		// bridge cut-out
		roundedcube(size=[100, 60, 70], center=true, radius=15);
	}
}

module tube_holder_cut(is_top=false) {
	intersection() {
		tube_holder_all();
		translate([0, 0, 66])
			poly_block(is_top);

		// Get parametric surface on the top lid
		// if (is_top)
		// 	// rotate([0, crt_angle, 0])
		// 		translate([0, 0, h - 10])
		// 			poly_block(0);
	}
}

module ui_cap() {
	height = 30;
	wall = 3;
	difference(){
		roundedcubez(size=[50, 100, height], center=true, radius=15);

		// Cut the front at an angle
		translate([57, 0, 30])
			rotate([0, 60, 0])
				cube(size=[100, 150, 100], center=true);

		// Cut the back
		translate([-45, 0, 30])
			cube(size=[100, 110, 100], center=true);

		// Cut the middle
		translate([0, 0, 40])
			cube(size=[100, 65, 100], center=true);

		for (i=[-1, 1]) {
			// screw holes
			translate([14, 40 * i, -22])
				cylinder(h=40, d=5.25, center=true);
			// square nut slot
			translate([-3, 40 * i, -height / 2 + 5])
				cube(size=[45, 8.5, 3], center=true);

			translate([14, 40 * i, 5]) {
				rotate([0, 60, 0]) {
					// PCB holes
					cylinder(h=40, d=5.25, center=true);
					// square nut
					translate([0, 0, -13])
						cube(size=[8.5, 8.5, 10], center=true);
				}
			}
		}
	}

	// square nut
	// translate([14, 40, -height / 2 + 5])
	// 	square_nut_m5();

	// screw
	// translate([14, 40, -20.0])
	// 	bolt_m5_16_cs(true);
}

module ui_pcb() {
	translate([16.6, 0, 0])
		rotate([0, 60, 0])
			translate([117, -50, 0])
				rotate([0, 0, 90])
					linear_extrude(1.6)
						import("ui_pcb_edge.svg");
}

module main() {
	tube_holder_cut(1);
	// screw
	translate([0, 40, 77.6])
		bolt_m5_20_hx();
	tube_holder_cut(0);
	pos_crt();
	translate([pcb_x, 0, 0])
		crt_pcb();
	crt_plate();
	translate([125, 0, (30 + 5) / 2]) {
		ui_cap();
		ui_pcb();
	}
}

// intersection() {
	main();
// 	translate([0, 190, 0])
// 		cube([300, 300, 300], center=true);
// }

// projection()
// 	plate();

// projection(true)
// 	translate([0, 0, -14.3])
// 		rotate([0, -60, 0])
// 			ui_cap();

