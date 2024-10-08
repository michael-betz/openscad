$fn = $preview ? 30 : 100;

include <crt.scad>
include <../../roundedcube.scad>
include <../../ali_parts.scad>
include <../crt_lib.scad>

crt_angle = 15;

plate_l = 250;
plate_x = 15;
plate_width = 110;
screw_width_top = plate_width - 50;
screw_width = plate_width - 16;

holder_height = 90;
pcb_x = 35;

module pos_crt(s=1.0) {
	translate([0, 0, 65])
		rotate([180, 90 - crt_angle, 0])
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
			translate([0, screw_width_top / 2 * i, holder_height + 7])
				cylinder(h=40, d=9, center=true);  //, $fn=6);
			translate([0, screw_width_top / 2 * i, holder_height - 25])
				cylinder(h=50, d=5.25, center=true);
			translate([0, screw_width / 2 * i, 0])
				cylinder(h=50, d=5.25, center=true);

			// bevel the edges
			translate([0, -60 * i, 130])
				rotate([-70 * i, 0, 0])
					cube(size=[100, 100, 100], center=true);
		}
		// Top square nuts
		translate([0, 0, z_cut - 7])
			cube(size=[8.5, 72, 3], center=true);

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

module encoder_stamp() {
	// difference() {
		// translate([0, 0, 5 - 4])
		// 	cube(size=[30, 30, 10], center=true);
		cylinder(h=10, d=10, center=true);
		translate([-9.3, 0, 0])
			cylinder(h=5, d=3.5, center=true);
		translate([0, 0, 25]) {
			translate([-0.7 / 2 - 0.4, 0, 0])
				cube(size=[(9.3 + 8.3) + 3, 16.8 + 2, 50], center=true);
			translate([-13.5 / 2, 0, 0])
				cube(size=[14.5, 4 + 2, 50], center=true);
		}
	// }
}

module encoder_holder() {
	holder_height = 20;
	holder_z = 2.5 + holder_height / 2;

	translate([-9, 0, 0]) {
		intersection() {
			minkowski() {
				d = 30;
				difference() {
					cube(size=[40 - d, plate_width - d, 60-d], center=true);
					translate([22, 0, 18.5])
						rotate([0, -50, 0])
							cube(size=[50, 150, 100], center=true);

					for (i=[-1,1]) {
						translate([0, i * 25, 22])
							rotate([-15 * i, 0, 0])
								cube(size=[40, 40, 60-d], center=true);
					}
				}
				sphere(d=d);
			}
			translate([17, 0, 25])
				cube([50, 150, 50], center=true);
		}
	}
}

module encoder_holder_cut() {
	difference() {
		!encoder_holder();
		translate([-2, 0, 12.0])
			rotate([0, 270 - 50, 0])
				encoder_stamp();
		for (i=[-1,1]) {
			// screw holes
			translate([0, screw_width / 2 * i, 3.5])
				cylinder(h=15, d=5.25, center=true);
			// square nut solts
			translate([-10, screw_width / 2 * i, 3])
				cube(size=[8.5 + 20, 8.5, 3], center=true);
		}
	}
}

module main() {
	color("white")
		pos_crt();

	tube_holder_cut(1);
	// screw
	translate([0, screw_width_top / 2, 78])
		bolt_m5_20_hx();
	tube_holder_cut(0);

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
	// translate([0, 150 -screw_width / 2, 0])
	// 	cube([1000, 300, 500], center=true);
}

// projection()
// 	plate();

