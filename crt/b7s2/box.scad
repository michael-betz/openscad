$fn = $preview ? 30 : 100;

include <crt.scad>
include <../../roundedcube.scad>
include <../../ali_parts.scad>
include <../crt_lib.scad>

crt_angle = 15;

plate_l = 220;
plate_x = 5;
plate_width = 90;
screw_width_top = plate_width - 20;
screw_width = plate_width - 16;

holder_height = 95;
pcb_x = 0;

module pos_crt(s=1.0) {
	translate([90, 0, 93])
		rotate([0, 90 - crt_angle, 0])
			scale([s, s, 1])
				crt();
}

module tube_holder_base() {
	holder_z = 2.5 + holder_height / 2;
	difference() {
		translate([0, 0, holder_z])
			roundedcubez(size=[40, plate_width, holder_height], center=true, radius=15);
		pos_crt(1.05);
	}
}

z_cut = 70;

module tube_holder_all() {
	difference() {
		tube_holder_base();
		for (i=[-1,1]) {
			translate([0, screw_width_top / 2 * i, holder_height])
				cylinder(h=40, d=9, center=true);  //, $fn=6);
			translate([0, screw_width_top / 2 * i, holder_height - 25])
				cylinder(h=50, d=5.25, center=true);
			translate([0, screw_width / 2 * i, 0])
				cylinder(h=50, d=5.25, center=true);

			// bevel the edges
			translate([0, -60 * i, 135])
				rotate([-70 * i, 0, 0])
					cube(size=[100, 100, 100], center=true);
		}
		// Top square nuts
		translate([0, 0, z_cut - 7])
			cube(size=[8.5, screw_width_top + 11, 3], center=true);

		// Bottom square nuts
		translate([0, 0, 10])
			cube(size=[8.5, screw_width + 11, 3], center=true);

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
	translate([0, screw_width_top / 2, 75.5])
		bolt_m5_20_hx();
	!tube_holder_cut(0);

	crt_plate();

	translate([pcb_x, 0, 0])
		crt_pcb();

	translate([plate_l / 2 - 11 + plate_x, 0, 2.5])
		encoder_holder_cut();

	translate([plate_l / 2 - 11 + plate_x, -screw_width / 2, -2.6])
		bolt_m5_16_cs(true);
}

intersection() {
	main();
	// translate([0, -152 +screw_width / 2, 0])
	// translate([500, 0, 0])
	// 	cube([1000, 300, 500], center=true);
}

// projection()
// 	plate();

