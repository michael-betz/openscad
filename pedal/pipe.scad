$fn = $preview ? 30 : 100;

include <../roundedcube.scad>
include <../ali_parts.scad>

module pipe() {
	difference() {
		cylinder(h=600, d=25, center=true);
		cylinder(h=601, d=23, center=true);
	}
}

module batt() {
	cylinder(h=65.6, d=18.5, center=true);
}

module vesc() {
	cube([65, 39, 13], center=true);
}

module bms(){
	cube([61, 33, 9], center=true);
}

module box() {
	difference() {
		cube(size=[105, 165, 30], center=true);
		translate([0, 0, 5])
			scale(0.99)
				cube(size=[105, 165, 40], center=true);
	}

	translate([0, -20, 0])
		vesc();
	translate([0, 20, 0])
		bms();

	color("green")
		translate([0, 0, -31.5])
			rotate([0, 180, 0])
				clamp();
}

module clamp() {
	difference() {
		translate([0, 0, -9])
			intersection() {
				roundedcube(size=[60, 165, 15], center=true, radius=20);
				cube(size=[60, 165, 14.9], center=true);
			}
		// top cut
		rotate([90, 0, 0])
			cylinder(d=25.5, h=180, center=true);
		// zip tie cuts
		for (i=[-60, 0, 60])
			translate([0, i - 15, 0])
				rotate([90, 0, 0])
					difference() {
						cylinder(d=40, h=7, center=true);
						cylinder(d=30, h=8, center=true);
					}
	}
}


module coupler() {
	difference() {
		cylinder(h=62.5, d=27, center=true);
		for (i=[-1, 1])
			translate([0, 0, i * (-12 + 62.6 / 2)])
				cylinder(h=24, d=25, center=true);
		cylinder(h=63, d=20, center=true);
	}
}

module handle() {
	import("handle_solo.stl");
	translate([0, 0, -10])
		cylinder(d=22.5, h=20, center=true);
}

module assembly1() {
	pipe();

	color("yellow")
		translate([0, 0, -62.5 / 2 + 24 - 600 / 2])
	 		coupler();

	batt_pitch = 67;
	for (i=[-3:4])
		translate([0, 0, i * batt_pitch - 60])
			batt();

	translate([0, -31.5, 200])
		rotate([90, 0, 0])
			box();

	translate([0, 0, 304])
		handle();
}

module assembly2() {
	pipe();
	color("yellow")
	translate([0, 0, -62.5 / 2 + 24 - 600 / 2])
 		coupler();
}

module square(dx=10, dz=0) {
	for (j=[-1, 1])
		for (i=[-1, 1])
			translate([i * dx, 0, j * dz])
				children();
}

module square2(dx=10, dz=0) {
	for (i=[-1, 1]) {
		translate([i * dx, 0, 0])
			children();
		translate([0, 0, i * dz])
			children();
	}
}

module bottom_clamp() {
	clamp_z = 19;
	clamp_x = 16;

	difference() {
		cube(size=[65, 40, 60], center=true);

		// central hole
		cylinder(h=100, d=25, center=true);

		// Slot between the 2 half-blocks
		cube(size=[70, 2, 70], center=true);

		// Square nut slots
		square(clamp_x + 5, clamp_z)
			translate([0, 7, 0])
				cube(size=[18.5, 3, 8.5], center=true);

		square(clamp_x, clamp_z) {
			// Screw holes
			translate([0, -5, 0])
				rotate([90, 0, 0])
					cylinder(h=40, d=6, center=true);
			// Screw head holes
			translate([0, -17, 0])
				rotate([90, 0, 0])
					cylinder(h=15, d=10, center=true);
		}

		// Mounting holes for thrusters
		square2(24, 14)
			rotate([90, 0, 0]) {
				cylinder(d=4.2, h=50, center=true);
				// Blind holes for the screw head
				cylinder(d=10, h=25 + 4 * 2, center=true);
			}
	}

	// !!! Hardware !!!
	// M5 bolt
	// translate([clamp_x, -10, clamp_z])
	// 	rotate([90, 0, 0])
	// 		bolt_m5_20_hx(head_up=false);

	// M5 square nut
	// translate([clamp_x, 7, clamp_z])
	// 	rotate([90, 0, 0])
	// 		square_nut_m5();

	// M4 bolt
	// translate([0, 32.5, 14])
	// 	rotate([90, 0, 0])
	// 		bolt("M4", length=16, kind="socket_head");
}

module bottom_clamp_cut() {
	intersection() {
		bottom_clamp();
		rotate([90, 0, 0])
			cylinder(h=100, d=70, center=true, $fn=6);
	}
}

module assembly3() {
	pipe();
	translate([0, 0, -272])
		bottom_clamp();
}


intersection() {
	// union() {
	// 	difference() {
	// 		assembly1();
	// 		// Cable hole
	// 		translate([0, -8, 270])
	// 			rotate([90, 0, 0])
	// 				cylinder(d=15, h=10);
	// 	}
	// 	translate([0, 0, -615])
	// 		assembly2();
	// 	translate([0, 0, -1200])
	// 		assembly3();
	// }
	bottom_clamp_cut();
	translate([0, 50, 0])
		cube(size=[100, 100, 5000], center=true);
}


