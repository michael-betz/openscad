$fn = $preview ? 30 : 100;

crt_angle = 12;

plate_l=310;
plate_x=-15;
plate_width = 110;
screw_width = plate_width - 16;

h = 110;
z = 2.5 + h / 2;
pcb_x = 35;

include <crt.scad>
include <../../roundedcube.scad>
include <../../ali_parts.scad>
include <../crt_lib.scad>

module pos_crt(s=1.0) {
	translate([0, 0, 75])
		rotate([180, 90 - crt_angle, 0])
			scale([s, s, 1])
				crt();
}

module tube_holder_base() {
	difference() {
		translate([0, 0, z])
			roundedcubez(size=[60, plate_width, h], center=true, radius=15);
		pos_crt(1.05);
	}
}

z_cut = 70;

module tube_holder_all() {
	difference() {
		tube_holder_base();
		for (i=[-1,1]) {
			translate([0, screw_width / 2 * i, h - 12])
				cylinder(h=40, d=9, center=true);  //, $fn=6);
			translate([0, screw_width / 2 * i, 50])
				cylinder(h=150, d=5.25, center=true);
		}
		// Top square nuts
		translate([0, 0, z_cut - 6])
			cube(size=[8.5, plate_width - 5, 3], center=true);

		// Bottom square nuts
		translate([0, 0, 10])
			cube(size=[8.5, plate_width - 5, 3], center=true);

		// bridge cut-out
		roundedcube(size=[100, plate_width - 40, 73], center=true, radius=15);
	}
}

module tube_holder_cut(is_top=false) {
	intersection() {
		tube_holder_all();
		translate([0, 0, z_cut])
			poly_block(is_top);
	}
}

module main() {
	color("white")
		pos_crt();

	tube_holder_cut(1);
	// screw
	translate([0, screw_width / 2, 78])
		bolt_m5_20_hx();
	tube_holder_cut(0);

	// tube_holder_back(-310, 1);
	// tube_holder_back(-310, 0);
	// tube_holder_mid();
	crt_plate();

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
	// translate([-500, 0, 0])
	// 	cube([1000, 300, 500], center=true);
}

// projection()
// 	plate();

