$fn = $preview ? 30 : 100;

include <roundedcube.scad>

// Fits on our big creality 3D printer head
module mounting_plate() {
	holes = [[0, 0], [-14, 0], [1, 25], [1 - 44, 25]];
	spacer_height = 3.5;
	t_plate = 6;

	translate([0, 0, -t_plate])
		difference() {
			union() {
				translate([-52, -7, 0])
					cube([73, 39, t_plate]);
				// spacers
				for (p = holes)
					translate([p[0], p[1], -spacer_height])
						cylinder(h=spacer_height, d=13, center=false);
			}

			// Trough holes
			for (p = holes)
				translate([p[0], p[1], 0])
					cylinder(h=20, d=3.5, center=true);

			// Holes for metal standoffs
			for (p = [holes[0], holes[1]]) {
				translate([p[0], p[1], -spacer_height - 0.01])
					cylinder(h=5, d=5.5, center=false);
			}

			// countersink
			for (p = holes) {
				translate([p[0], p[1], t_plate - 1.6])
					cylinder(h=1.75, d1=3, d2=6, center=false);
			}
		}
}

module syringe() {
	translate([0, 0, 97 + 5 + 2])
		rotate([180, 0, 0])
			rotate_extrude()
				polygon([
					[0, 0],
					[25.5 / 2, 0],
					[25.2 / 2, 97],
					[10.2 / 2, 97 + 5],
					[10.2 / 2, 97 + 5 + 7.5],
					[0, 97 + 5 + 7.5],
				]);
}

module s_holder() {
	h = 20;  // extra height
	difference() {
		union() {
			// Back part
			translate([-15, -15, 0])
				cube(size=[15, 30, 30 + h]);
			// clamp bracket
			translate([0, 0, h + 15])
				cylinder(h=15, d=30, center=false);
			// clamp block
			translate([-4, 0, h + 15])
				cube_(size=[22, 50, 15]);
			// mounting block
			translate([-15 / 2, 0, h])
				cube_(size=[15, 50, 15]);
			// Bottom part
			cylinder(h=14.5, d=30, center=false);
		}
		scale(1.02)
			syringe();

		// clamp slot
		translate([0.5, 0, h + 15])
			cube_(size=[1, 60, 16]);

		// screw holes
		for (i=[-1, 1])
			for (j=[-1, 1])
				translate([-5, 19 * i, h + 15 + 7.5 * j])
					rotate([0, 90, 0])
						cylinder(h=35, d=6, center=true);

		// Embedded square nuts
		for (i=[-1, 1])
			translate([-10, 19 * i, h + 15 + 7.5])
				cube(size=[4, 9, 9], center=true);
	}
}

module cut_corner() {
	// Clearance stuff
	translate([0, -36.65, -11.35])
		rotate([10, 0, 0])
			cube(size=[50, 40, 30], center=true);
	translate([0, -39.6, -8.1])
		cube(size=[50, 40, 30], center=true);

	// Square nut [pockets]
	translate([15, -1, -11])
		rotate([10, 0, 0])
			for (i=[-1, 1])
				translate([-5, 19 * i, 20 + 15 - 7.5]) {
					rotate([0, 90, 0])
						cylinder(h=35, d=6, center=true);
					translate([-16, 0, 0])
						cube(size=[4, 9, 9], center=true);
				}
}

// Assembly and some final corner cutting
// Select elements to export here by commenting
module assembly() {
	color("red")
		rotate([90, 0, 90])
			mounting_plate();

	translate([15, -1, -11])
		rotate([10, 0, 0]) {
			// color("yellow")
			// 	syringe();
			s_holder();
		}
}

module final() {
	difference() {
		assembly();
		cut_corner();
	}
}

final();

// cut view
// intersection() {
// 	final();
// 	translate([-100, 0, 0])
// 		cube(size=[200, 200, 200], center=true);
// }
