$fn = $preview ? 30 : 150;

include <../../ali_parts.scad>

angle_x = 45;
angle_y = -15;
crt_hole_height = 12;

module crt_flange_pos() {
	difference() {
		union() {
			// flat area for CRT socket
			translate([10, 0, 0])
				rotate([0, 90, 0])
					cylinder(h=20, d1=22, d2=27, center=true);

			// flat area for screws
			// for (i=[-1, 1])
			// 	translate([10, i * 22 / 2, 0])
			// 		rotate([0, 90, 14 * i])
			// 			cylinder(h=24, d=11.5, center=true);
		}
	}
}

module crt_flange_neg() {
	for (i=[-1, 1]) {
		// screw holes
		translate([15, i * 28 / 2, 0])
			rotate([0, 90, 0])
				cylinder(h=30, d=3.5, center=true);

		// square nut slots
		translate([6, i * 28 / 2, 0])
			translate([0, i * -2.5, 0])
				cube(size=[2.25, 11, 6], center=true);
	}
	// hole for CRT socket
	translate([15, 0, 0])
		rotate([0, 90, 0])
			cylinder(h=50, d=23, center=true);

	// cut the front face
	translate([59, 0, 0])
		cube(size=[100, 100, 100], center=true);
}


module main() {
	d1 = 25;
	d2 = 40;
	fn = 9;

	difference() {
		union() {
			// outer diameter
			translate([0, 0, 20 / 2])
				cylinder(h=40, d=d2, center=true);
			cylinder(h=60, d=d1, center=true);
			translate([0, 0, crt_hole_height])
				rotate([angle_x, angle_y, 0])
					crt_flange_pos();
		}

		// CRT hole
		translate([0, 0, crt_hole_height])
			rotate([angle_x, angle_y, 0])
				crt_flange_neg();

		// inner diameter
		translate([0, 0, -2 - 11])
			cylinder(h=60, d=d1 - 4, center=true);
	}
}

// Hardware
// translate([6, -14, crt_hole_height])
// 	rotate([0, 90, 0])
// 		square_nut_m3();

intersection() {
	// difference() {
	// 	crt_flange_pos();
	// 	crt_flange_neg();
	// }
	main();
	// translate([0, -50, 0])
	// 	cube(size=[100, 100, 100], center=true);
}

