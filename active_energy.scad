$fn = $preview ? 30 : 100;

include <roundedcube.scad>
include <ali_parts.scad>

// PCB mounting
w_mount = 52.8;
h_mount = 31.6;


module clip() {
	translate([5, 0, -7.5])
		difference() {
			translate([-5, 0, -7.5])
				roundedcubez_(size=[75, 60, 15], radius=10);
			translate([3, 0, 0]) {
				translate([-17.5 - 8, 0, -27.5 + 5])
					cube(size=[100, 40, 40], center=true);
				translate([-17.5 - 8, 0, 0])
					cube(size=[100, 53, 5.1], center=true);
			}
			for (i=[-1, 1])
				translate([30, 9 * i, -1])
					rotate([0, 90, 0])
						cylinder(h=20, d=7, center=true);

			// Slot for clip
			translate([29.5 - 59 + 2, 0, 5])
				cube(size=[10, 25, 10], center=true);

			// bottom cut
			translate([19.5 - 50 - 45, 0, -7.5])
				cube(size=[10 + 100, 100, 20], center=true);

			// taper triangle
			translate([-68, 0, -7.5])
				intersection() {
					cylinder(h=20, d=200, $fn=3, center=true);
					cube(size=[150, 200, 21], center=true);
				}

			translate([-12, 0, -5])
				difference() {
					cube_(size=[20, 53, 5]);
					translate([17, 0, -6])
						rotate([0, -10, 0])
							cube_(size=[50, 53, 10]);
				}

			// PCB mounting
			for (i=[-1, 1])
				for (j=[-1, 1])
					translate([i * w_mount / 2 - 10, j * h_mount / 2, 0]) {
						cylinder(h=20, d=3.5, center=true);
						cylinder(h=5.5 + 2.5 * 2, d=8, center=true);
					}
		}
}

// Power supply
module psu() {
	translate([0, 26, (38.5 - 43) / 2])
		cube_(size=[79, 2, 43]);
	cube_(size=[71.5, 50, 38.5]);
}

// psu();

clip();

// translate([w_mount/2 - 5, h_mount/2, -10])
// 	bolt_m3_20_cs(head_up=true);

