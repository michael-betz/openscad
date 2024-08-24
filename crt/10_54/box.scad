$fn = $preview ? 30 : 100;

include <crt.scad>
include <../../roundedcube.scad>
include <../../ali_parts.scad>

crt_angle = 12;
plate_width = 110;
h = 110;
z = 2.5 + h / 2;

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
			translate([0, (plate_width / 2 - 8) * i, h + 5])
				cylinder(h=35, d=9, center=true);  //, $fn=6);
			translate([0, (plate_width / 2 - 8) * i, 50])
				cylinder(h=150, d=5.25, center=true);
		}
		// Top square nuts
		translate([0, 0, z_cut - 6])
			cube(size=[8.5, 90, 3], center=true);

		// Bottom square nuts
		translate([0, 0, 10])
			cube(size=[8.5, 90, 3], center=true);

		// bridge cut-out
		roundedcube(size=[100, plate_width - 40, 73], center=true, radius=15);
	}
}

module poly_block(is_top=false) {
	include <../../poly_surface.scad>

	function fct(x, y) = 3 * sin(10 * x + 100) * sin(9 * y + 100) + sin(crt_angle) * x;

	function ftop(x,y) = is_top ? 70 : fct(x, y) - 1;
	function fbottom(x,y) = is_top ? fct(x, y) + 1 : -70;

    poly_surface(-40, 40, -plate_width / 2 - 10, plate_width / 2 + 10, $fn, $fn);
}

module tube_holder_cut(is_top=false) {
	intersection() {
		tube_holder_all();
		translate([0, 0, z_cut])
			poly_block(is_top);
	}
}

// PCB
module pcb() {
	// Use 10 mm standoffs
	translate([6.7, 0, 1.95 + 1.6 + 10]) {
		cube(size=[150, 50, 1.6], center=true);
		// hole pattern
		for (y=[-21, 21]) {
			for (x=[11, 56, 139]) {
				translate([75 - x, y, -5 - 1.6 / 2]) {
					spacer_m3_10();
					translate([0, 0, -6])
						cylinder(h=12, d=3.2, center=true);
				}
			}
		}
		// Filament transformer
		color("white")
			translate([-15, 0, 10])
				cube(size=[22, 13, 20], center=true);
		// Potentiometers
		color("blue")
			translate([-75 - 6.75 / 2 + 38.5, 25 - 4.82 / 2, 3.5])
				cube(size=[6.75, 4.82, 7], center=true);
		color("blue")
			translate([75 + 6.75 / 2 - 51.5, -25 + 4.82 / 2, 3.5])
				cube(size=[6.75, 4.82, 7], center=true);
	}
}

module pcb_holes() {
	for (y=[-1, 1])
		for (x=[0, 45, 128])
			translate([64 - x, 42 / 2 * y, 0])
				cylinder(h=30, d=3.2, center=true);
}

module plate() {
	plate_l = 310;
	plate_holes_y = (plate_width / 2 - 8);
	plate_x = -15;
	difference() {
		translate([plate_x, 0, 0])
			roundedcubez(size=[plate_l, plate_width, 5], center=true, radius=15);
		for (i=[-1,1]) {
			// tube_holder_mid holes
			translate([0, plate_holes_y * i, 0])
				cylinder(h=10, d=5.25, center=true);

			// tube_holder_back holes
			// translate([-plate_l / 2 + plate_x + 14, plate_holes_y * i, 0])
			// 	cylinder(h=10, d=5.25, center=true);
			// translate([-plate_l / 2 + plate_x + 62, plate_holes_y * i, 0])
			// 	cylinder(h=10, d=5.25, center=true);

			// UI board holes
			translate([plate_l / 2 - 11 + plate_x, plate_holes_y * i, 0])
				cylinder(h=10, d=5.25, center=true);

			// PCB mounting holes
			translate([6, 0, 0])
				pcb_holes();
		}
	}
}

module main() {
	// color("white")
	// 	pos_crt();

	tube_holder_cut(1);
	// screw
	// translate([0, 40, 77.6])
	// 	bolt_m5_20_hx();
	tube_holder_cut(0);

	// tube_holder_back(-310, 1);
	// tube_holder_back(-310, 0);
	// tube_holder_mid();
	plate();

	translate([6-6.7, 0, 0])
		pcb();

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

