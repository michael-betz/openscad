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

// module crt_pcb_holes() {
// 	translate([6.7, 0, 1.95 + 1.6 + 10])
// 		for (y=[-21, 21])
// 			for (x=[11, 56, 139])
// 				translate([75 - x, y, -5 - 1.6 / 2])
// 					translate([0, 0, -6])
// 						cylinder(h=12, d=3.2, center=true);
// }


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
