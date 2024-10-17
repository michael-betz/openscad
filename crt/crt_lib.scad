include <../roundedcube.scad>
include <../ali_parts.scad>

// PCB
module crt_pcb() {
	// Use 10 mm standoffs
	translate([0, 0, 1.95 + 1.6 + 10]) {
		color("green")
			cube(size=[150, 50, 1.6], center=true);
		// spacers
		for (y=[-21, 21])
			for (x=[11, 56, 139])
				translate([75 - x, y, -5 - 1.6 / 2])
					spacer_m3_10();
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

module crt_pcb_holes() {
	// hole pattern
	for (y=[-1, 1])
		for (x=[0, 45, 128])
			translate([64 - x, 42 / 2 * y, 0])
				cylinder(h=30, d=3.2, center=true);
}

module crt_plate(add_back_holder_holes=false) {
	difference() {
		translate([plate_x, 0, 0])
			roundedcubez(size=[plate_l, plate_width, 5], center=true, radius=15);
		for (i=[-1,1]) {
			// tube_holder_mid holes
			translate([0, screw_width / 2 * i, 0])
				cylinder(h=10, d=5.25, center=true);

			if (add_back_holder_holes) {
				translate([-plate_l / 2 + plate_x + 14, screw_width / 2 * i, 0])
					cylinder(h=10, d=5.25, center=true);
				translate([-plate_l / 2 + plate_x + 62, screw_width / 2 * i, 0])
					cylinder(h=10, d=5.25, center=true);
			}

			// UI board holes
			translate([plate_l / 2 - 11 + plate_x, screw_width / 2 * i, 0])
				cylinder(h=10, d=5.25, center=true);

			// PCB mounting holes
			translate([pcb_x, 0, 0])
				crt_pcb_holes();
		}
	}
}

module poly_block(is_top=false) {
	include <../poly_surface.scad>

	function fct(x, y) = 3 * sin(10 * x + 100) * sin(9 * y + 100) + sin(crt_angle) * x;

	function ftop(x,y) = is_top ? 70 : fct(x, y) - 1;
	function fbottom(x,y) = is_top ? fct(x, y) + 1 : -70;

    poly_surface(-40, 40, -plate_width / 2 - 10, plate_width / 2 + 10, $fn, $fn);
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
		encoder_holder();
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
